%load('T_sigma.mat')
%npdata = readtable('BECTS_np_database.xlsx');
T=T_sigma;
T.patient_name=categorical(cellstr(T.patient_name));
%% Initialize everything
patient_names = unique(T.patient_name);  % Unique list of patient names
% patient_names = {'pBECTS003','pBECTS006','pBECTS007','pBECTS013','pBECTS019',...
% 'pBECTS020'};
% 
% patient_names ={'pBECTS001', 'pBECTS003', 'pBECTS004','pBECTS006','pBECTS007','pBECTS019',...
%     'pBECTS020', 'pBECTS025', 'pBECTS027','pBECTS030',...
%      'pBECTS031','pBECTS040','pBECTS042',...
%      'pBECTS043' ,'pBECTS044' ,'pBECTS045','pBECTS046' ,'pBECTS047'};
males         = nan(1,length(patient_names));   % 1 = boy; 0 = girl;
hc            = nan(1,length(patient_names));   % 1 = healthy; 0 = active or remission
rBECTS        = nan(1,length(patient_names));   % 1 = remission; 0 = active or healthy
aBECTS        = nan(1,length(patient_names));   % 1 = active; 0 = healthy or remission
rightHand     = nan(1,length(patient_names));   % 0 = L; 1 = R;
age           = nan(1,length(patient_names));   % age;
taskPeg       = nan(1,length(patient_names));   % performance on Pegboard
taskPegZ       = nan(1,length(patient_names));   % performance on Pegboard
taskPeg_nondom       = nan(1,length(patient_names));   % performance on Pegboard
taskPegZ_nondom       = nan(1,length(patient_names));   % performance on Pegboard
taskPho       = nan(1,length(patient_names));   % performance of phonemic awareness task
cohLeft        = nan(1,length(patient_names));   % coherence in SOZ mean of L and R
cohRight        = nan(1,length(patient_names));   % coherence in SOZ mean of L and R

cohSOZ        = nan(1,length(patient_names));   % coherence in SOZ mean of L and R
cohLang       = nan(1,length(patient_names));   % coherence from left SOZ to left STL
cohAcross     = nan(1,length(patient_names));   % coherence from left SOZ to right SOZ

cohPrePost    = nan(1,length(patient_names));   % coherence between pre post CG
cohPrePost_upper= nan(1,length(patient_names));   % coherence between and in pre post CG
cohPrePost_all    = nan(1,length(patient_names));   % coherence between pre post CG
cohPrePost_all_upper= nan(1,length(patient_names));   % coherence between and in pre post CG

cohPrePost_nondom    = nan(1,length(patient_names));   % coherence between pre post CG
cohPrePost_upper_nondom= nan(1,length(patient_names));   % coherence between and in pre post CG
cohPrePost_all_nondom    = nan(1,length(patient_names));   % coherence between pre post CG
cohPrePost_all_upper_nondom= nan(1,length(patient_names));   % coherence between and in pre post CG





affected_hem  = nan(1,length(patient_names));   % 0 = L; 1 = R; 2 = both; 3 = neither

affectedAndDom = nan(1,length(patient_names));  % 1 = if the affected hem is the dominant one


%% Read table into variables
spiking       = [];
nonspiking    = [];
hcsoz      =[];
for i = 1:length(patient_names) % [3 6 7 9 10 11];
    
    fprintf([char(patient_names(i)) '\n'])
    
    chunk = find(T.patient_name==patient_names(i));
    
    males(i)       = strcmp(T.gender(chunk(1)), 'M') ;
    hc(i)          = strcmp(T.status(chunk(1)),'Healthy') ;
    rBECTS(i)      = strcmp(T.status(chunk(1)), 'Remission') || ...
                        strcmp(T.status(chunk(1)), 'Seizure Free');
    aBECTS(i)      = strcmp(T.status(chunk(1)),'Active');
    rightHand(i)   = strcmp(T.hand(chunk(1)),'right');
    
    age(i)         = T.age(chunk(1));
    taskPeg(i)     = T.GPBdomRaw(chunk(1));
    taskPegZ(i)     = T.GPBdomZ(chunk(1));
        taskPeg_nondom(i)     = T.GPBnonRaw(chunk(1));
    taskPegZ_nondom(i)     = T.GPBnonZ(chunk(1));

    taskPhoRaw(i)     = T.PhonoAwareRaw(chunk(1));
    taskPhoZ(i)     = T.PhonoAwareZ(chunk(1));
    

    cohLeft(i)     = nanmean(T.leftSOZ(chunk));
    cohRight(i)    = nanmean(T.rightSOZ(chunk));
    cohSOZ(i)      = nanmean([nanmean(T.leftSOZ(chunk)),nanmean(T.rightSOZ(chunk))]);
    cohLang(i)     = nanmean(T.L_STL_SOZ(chunk));
    cohAcross(i)   = nanmean(T.acrossSOZ(chunk));

        cohPrePost(i)  = nanmean(T.prepostSOZ(chunk));
    cohPrePost_all(i)= nanmean(T.prepostSOZ_all(chunk));

    
    cohPrePost(i)    = nanmean(T.prepostSOZ(chunk));
cohPrePost_upper(i)= nanmean(T.prepostSOZ_upper(chunk));
cohPrePost_all(i)   = nanmean(T.prepostSOZ_all(chunk));
cohPrePost_all_upper(i)=nanmean(T.prepostSOZ_all_upper(chunk)); 

cohPrePost_nondom(i)   = nanmean(T.prepostSOZ_nondom(chunk)); 
cohPrePost_upper_nondom(i)= nanmean(T.prepostSOZ_upper_nondom(chunk));   
cohPrePost_all_nondom(i)   = nanmean(T.prepostSOZ_all_nondom(chunk));   
cohPrePost_all_upper_nondom(i)= nanmean(T.prepostSOZ_all_upper_nondom(chunk));  

    
    
    
    
    if strcmp(T.SpikingHemisphere(chunk(1)),'left') && ~hc(i)
        affected_hem(i) = 0;
        spiking         = [spiking, nanmean(T.leftSOZ(chunk))];
        nonspiking      = [nonspiking,nanmean(T.rightSOZ(chunk))];
        
        if rightHand(i) == 1
            affectedAndDom(i) = 1;
        else
            affectedAndDom(i) = 0;
        end
        
    elseif strcmp(T.SpikingHemisphere(chunk(1)),'right') && ~hc(i)
        affected_hem(i)=1;
        nonspiking = [nonspiking, nanmean(T.leftSOZ(chunk))];
        spiking =[spiking,nanmean(T.rightSOZ(chunk))];
        
        if rightHand(i) == 0
            affectedAndDom(i) = 1;
        else
            affectedAndDom(i) = 0;
        end
        
    elseif strcmp(T.SpikingHemisphere(chunk(1)),'both') && ~hc(i)
        affected_hem(i)=2;
        spiking =[spiking,nanmean(T.rightSOZ(chunk)), nanmean(T.leftSOZ(chunk))];
        
        affectedAndDom(i) = 1;
       
    elseif strcmp(T.SpikingHemisphere(chunk(1)),'neither') && ~hc(i)
        affected_hem(i)=3;
        nonspiking =[nonspiking,nanmean(T.rightSOZ(chunk)), nanmean(T.leftSOZ(chunk))];
        
        affectedAndDom(i) = 0;
    elseif hc(i)
        hcsoz=[hcsoz,nanmean(T.rightSOZ(chunk)), nanmean(T.leftSOZ(chunk))];
    end
    
    
    
end

%% Convert all to logicals
males     = logical(males);
rightHand = logical(rightHand);
hc        = logical(hc);
aBECTS    = logical(aBECTS);
rBECTS    = logical(rBECTS);

temp = char(patient_names);
temp = temp(:,end-1:end);
plabels = unique(cellstr(temp));

col = [ 0.4940 0.1840 0.5560;
    0.6032    0.8016    0.4000;
    0.9290    0.6940    0.1250];

% Define control regions

%% 1) Plot MOTOR STUFF


%% covars are same for all fits
covars.rightHand = [ones(size(rightHand)),zeros(size(rightHand))];
%[rightHand,rightHand];
covars.hc = [hc,hc];
covars.aBECTS = [aBECTS,aBECTS];
covars.rBECTS = [rBECTS,rBECTS];
labels.plabels = [plabels;plabels];
% covars.rightHand = [rightHand];
% covars.hc = [hc];
% covars.aBECTS = [aBECTS];
% covars.rBECTS = [rBECTS];
% labels.plabels = [plabels];

vars.x_obs = [cohPrePost,cohPrePost_nondom];
vars.y_obs = [taskPeg,taskPeg_nondom];
labels.xtitle = 'Sigma Coherence in Pre to Post Central Gyrus';
labels.ytitle = 'Grooved Pegboard Performance (s)';
labels.figtitle = 'Motor Task Performance vs Coherence in Motor Network';
plot_fit_glm(vars,covars,labels);



%% 2) Plot Phoneme Task Performance vs sigma coherence in Left SOZ to STL -- RIGHT HAND ONLY
%%% all are righthanded except for patient 4, SO want observation to be all

covars.rightHand = [rightHand];
covars.hc = [hc];
covars.aBECTS = [aBECTS];
covars.rBECTS = [rBECTS];
labels.plabels = [plabels];
cohLangTemp = cohLang;
cohLangTemp(hc) = NaN;
taskPhoTemp = taskPho;
taskPhoTemp(hc)=NaN;
vars.x_obs = cohLangTemp;
vars.y_obs = taskPhoTemp;
labels.ytitle = 'Phonemic Awareness Score (Raw)';
labels.xtitle = 'left SOZ to left STL';
labels.figtitle = 'Lang Performance vs Sigma Coherence';
plot_fit_glm(vars,covars,labels);

%% 3) 

figure; 
subplot 121
barplot({'Active','Remission','Healthy'},cohPrePost(aBECTS),cohPrePost(rBECTS),cohPrePost(hc))
ylabel('Beta Coherence in Motor Network')
axis square
set(gca,'FontSize',18)
subplot 122
barplot({'Active','Remission','Healthy'},taskPeg(aBECTS),taskPeg(rBECTS),taskPeg(hc))
ylabel('Pegboard Time to Complete (seconds)')
axis square
set(gca,'FontSize',18)

figure;
subplot 121
barplot({'Active','Remission','Healthy'},cohLang(aBECTS),cohLang(rBECTS),cohLang(hc))
ylabel('Beta Coherence in Language Network')
axis square
set(gca,'FontSize',18)
subplot 122
barplot({'Active','Remission','Healthy'},taskPho(aBECTS),taskPho(rBECTS),taskPho(hc))
ylabel('Phonological Awareness Score')
axis square
set(gca,'FontSize',18)
%%
figure;
subplot 121
barplot({'Active','Remission','Healthy'},cohSOZ(aBECTS),cohSOZ(rBECTS),cohSOZ(hc))
ylabel('Sigma Coherence in SOZ')
axis square
set(gca,'FontSize',18)
subplot 122
barplot({'Active','Remission','Healthy'},cohAcross(aBECTS),cohAcross(rBECTS),cohAcross(hc))
ylabel('Sigma Coherence between SOZs')
axis square
[t,p]=ttest2(cohSOZ(aBECTS),cohSOZ(hc))
[t,p]=ttest2(cohAcross(aBECTS),cohAcross(hc))
[t,p]=ttest2(cohAcross(rBECTS),cohAcross(hc))

[t,p]=ttest2(cohAcross(rBECTS),cohAcross(aBECTS))

set(gca,'FontSize',18)
%%
figure;
barplot({'Active - Spiking','Active - Not Spiking','Healthy'},...
    spiking,nonspiking,hcsoz );
ylabel('Sigma Coherence in SOZ')
axis square
set(gca,'FontSize',18)

%%
figure; hold on;
plot(age(males & hc),cohSOZ(males & hc),'s','MarkerEdgeColor',col(1,:),'MarkerSize',8,'MarkerFaceColor',col(1,:));
plot(age(males & aBECTS),cohSOZ(males & aBECTS),'s','MarkerEdgeColor',col(2,:),'MarkerSize',8,'MarkerFaceColor',col(2,:));
plot(age(males & rBECTS),cohSOZ(males & rBECTS),'s','MarkerEdgeColor',col(3,:),'MarkerSize',8,'MarkerFaceColor',col(3,:));
plot(age(~males & hc),cohSOZ(~males & hc),'*','MarkerEdgeColor',col(1,:),'MarkerSize',8,'MarkerFaceColor',col(1,:));
plot(age(~males & aBECTS),cohSOZ(~males & aBECTS),'*','MarkerEdgeColor',col(2,:),'MarkerSize',8,'MarkerFaceColor',col(2,:));
plot(age(~males & rBECTS),cohSOZ(~males & rBECTS),'*','MarkerEdgeColor',col(3,:),'MarkerSize',8,'MarkerFaceColor',col(3,:));

legend('Healthy M', 'Active M', 'Remission M','Healthy F','Active F','Remission F')
%legend('Healthy M','Active M', 'Remission M','Healthy F','Active F','Remission F')

xlabel('Age')
ylabel('Sigma Coherence in SOZ')
set(gca,'FontSize',18)


figure; hold on;
plot(age(males & hc),cohPrePost(males & hc),'s','MarkerEdgeColor',col(1,:),'MarkerSize',8,'MarkerFaceColor',col(1,:));
plot(age(males & aBECTS),cohPrePost(males & aBECTS),'s','MarkerEdgeColor',col(2,:),'MarkerSize',8,'MarkerFaceColor',col(2,:));
plot(age(males & rBECTS),cohPrePost(males & rBECTS),'s','MarkerEdgeColor',col(3,:),'MarkerSize',8,'MarkerFaceColor',col(3,:));
plot(age(~males & hc),cohPrePost(~males & hc),'*','MarkerEdgeColor',col(1,:),'MarkerSize',8,'MarkerFaceColor',col(1,:));
plot(age(~males & aBECTS),cohPrePost(~males & aBECTS),'*','MarkerEdgeColor',col(2,:),'MarkerSize',8,'MarkerFaceColor',col(2,:));
plot(age(~males & rBECTS),cohPrePost(~males & rBECTS),'*','MarkerEdgeColor',col(3,:),'MarkerSize',8,'MarkerFaceColor',col(3,:));

legend('Healthy M', 'Active M', 'Remission M','Healthy F','Active F','Remission F')
%legend('Healthy M','Active M', 'Remission M','Healthy F','Active F','Remission F')

xlabel('Age')
ylabel('Sigma Coherence in Pre to Post CG')
set(gca,'FontSize',18)
figure; hold on;
plot(age(males & hc),cohLang(males & hc),'s','MarkerEdgeColor',col(1,:),'MarkerSize',8,'MarkerFaceColor',col(1,:));
plot(age(males & aBECTS),cohLang(males & aBECTS),'s','MarkerEdgeColor',col(2,:),'MarkerSize',8,'MarkerFaceColor',col(2,:));
plot(age(males & rBECTS),cohLang(males & rBECTS),'s','MarkerEdgeColor',col(3,:),'MarkerSize',8,'MarkerFaceColor',col(3,:));
plot(age(~males & hc),cohLang(~males & hc),'*','MarkerEdgeColor',col(1,:),'MarkerSize',8,'MarkerFaceColor',col(1,:));
plot(age(~males & aBECTS),cohLang(~males & aBECTS),'*','MarkerEdgeColor',col(2,:),'MarkerSize',8,'MarkerFaceColor',col(2,:));
plot(age(~males & rBECTS),cohLang(~males & rBECTS),'*','MarkerEdgeColor',col(3,:),'MarkerSize',8,'MarkerFaceColor',col(3,:));

legend('Healthy M', 'Active M', 'Remission M','Healthy F','Active F','Remission F')
%legend('Healthy M','Active M', 'Remission M','Healthy F','Active F','Remission F')

xlabel('Age')
ylabel('Sigma Coherence in Lang Network')
set(gca,'FontSize',18)

% %%
% idx=isnan(affectedAndDom);
% 
% mdl = fitglm(cohPrePost(affectedAndDom==1),taskPeg(affectedAndDom==1))
% b   = mdl.Coefficients.Estimate(1);
% m   = mdl.Coefficients.Estimate(2);
% 
% figure; hold on;
% plot(cohPrePost( hc),taskPeg( hc),'sb','MarkerSize',8)
% plot(cohPrePost(affectedAndDom==1 & aBECTS),taskPeg(affectedAndDom==1 & aBECTS),'sr','MarkerSize',8)
% plot(cohPrePost(affectedAndDom==1 & rBECTS),taskPeg(affectedAndDom==1 & rBECTS),'sm','MarkerSize',8)
% plot(cohPrePost(affectedAndDom==0 & aBECTS),taskPeg(affectedAndDom==0 & aBECTS),'*r','MarkerSize',8)
% plot(cohPrePost(affectedAndDom==0 & rBECTS),taskPeg(affectedAndDom==0 & rBECTS),'*m','MarkerSize',8)
% xaxis = min(cohPrePost):.001:max(cohPrePost);
% yaxis = b+m.*xaxis;
% plot(xaxis,yaxis,'--','LineWidth',2)
% plot(xaxis,yaxis,'--','LineWidth',2)
% %legend('Healthy','Active Affected','Remission Affected','Active Not Affected','Remission Not Affected',... 
%  %   ['y = ' num2str(m) 'x +' num2str(b), 'p=' num2str(mdl.Coefficients.pValue(2))])
% legend('Active Affected','Remission Affected','Active Not Affected','Remission Not Affected',... 
%     ['y = ' num2str(m) 'x +' num2str(b), 'p=' num2str(mdl.Coefficients.pValue(2))])
% labelpoints(cohPrePost,taskPeg,plabels)
% xlabel('Sigma Coherence in Pre Post CG')
% ylabel('Time to complete task (s)')
% set(gca,'FontSize',18)
% %%
% figure;
% barplot({'Active Affected','Active Not Affected','Remission Affected','Remission Not Affected'},taskPeg(affectedAndDom==1 & aBECTS),...
%    taskPeg(affectedAndDom==0 & aBECTS), taskPeg(affectedAndDom==1 & rBECTS),taskPeg(affectedAndDom== 0& rBECTS) )

%%
figure;
subplot 121
barplot({'Healthy','Active','Remission'},cohPrePost(hc),cohPrePost(aBECTS),cohPrePost(rBECTS))
ylabel('Between Pre Post')
axis square


subplot 122
barplot({'Healthy','Active','Remission'},cohPrePost(hc),cohPrePost_all(aBECTS),cohPrePost_all(rBECTS))
ylabel('Between and within Pre Post')
axis square





%%
figure;
subplot 121
barplot({'H - Left','H - Right','A - Left','A - Right','R - Left', 'R - Right'}...
    ,cohLeft(hc),cohRight(hc),cohLeft(aBECTS),cohRight(aBECTS),cohLeft(rBECTS),cohRight(rBECTS))
ylabel('SOZ')
axis square


subplot 122
barplot({'H - Left','H - Right','A - Left','A - Right','R - Left', 'R - Right'}...
    ,cohLcontrol(hc),cohRcontrol(hc),cohLcontrol(aBECTS),cohRcontrol(aBECTS),cohLcontrol(rBECTS),cohRcontrol(rBECTS))
ylabel('Superior Frontal Lobe')
axis square
%%
figure;
plot(cohLeft,cohLcontrol,'*')
hold on
plot(cohRight,cohRcontrol,'sq')
labelpoints(cohLeft,cohLcontrol,plabels)
labelpoints(cohRight,cohRcontrol,plabels)

%%
figure;
ax1=subplot(1,3,3);
plot(cohLeft(rBECTS),'*r','MarkerSize',7)
hold on
plot(cohLcontrol(rBECTS),'sqr','MarkerSize',7)
plot(cohRight(rBECTS),'*b','MarkerSize',7)
plot(cohRcontrol(rBECTS),'sqb','MarkerSize',7)
legend('left SOZ','left control','right SOZ','right control')
% labelpoints(1:9,cohLeft,plabels)
% labelpoints(1:9,cohLcontrol,plabels)
% labelpoints(1:9,cohRight,plabels)
% 
% labelpoints(1:9,cohRcontrol,plabels)
xticklabels(plabels(rBECTS))
xlabel('Patient No.')
ylabel('Sigma Coherence')
title('Remission')
set(gca,'FontSize',18)

ax2=subplot(1,3,2);
plot(cohLeft(aBECTS),'*r','MarkerSize',7)
hold on
plot(cohLcontrol(aBECTS),'sqr','MarkerSize',7)
plot(cohRight(aBECTS),'*b','MarkerSize',7)
plot(cohRcontrol(aBECTS),'sqb','MarkerSize',7)
% labelpoints(1:9,cohLeft,plabels)
% labelpoints(1:9,cohLcontrol,plabels)
% labelpoints(1:9,cohRight,plabels)
% 
% labelpoints(1:9,cohRcontrol,plabels)
xticklabels(plabels(aBECTS))
title('Active')
xlabel('Patient No.')
ylabel('Sigma Coherence')
set(gca,'FontSize',18)
ax3=subplot(1,3,1);
plot(cohLeft(hc),'*r','MarkerSize',7)
hold on
plot(cohLcontrol(hc),'sqr','MarkerSize',7)
plot(cohRight(hc),'*b','MarkerSize',7)
plot(cohRcontrol(hc),'sqb','MarkerSize',7)
% labelpoints(1:9,cohLeft,plabels)
% labelpoints(1:9,cohLcontrol,plabels)
% labelpoints(1:9,cohRight,plabels)
% 
% labelpoints(1:9,cohRcontrol,plabels)
xticklabels(plabels(hc))
title('Healthy')
xlabel('Patient No.')
ylabel('Sigma Coherence')


linkaxes([ax1,ax2,ax3],'y')
set(gca,'FontSize',18)
%%

%%


figure; hold on;
plot(age(males & hc),taskPeg(males & hc),'s','MarkerEdgeColor',col(1,:),'MarkerSize',8,'MarkerFaceColor',col(1,:));
plot(age(males & aBECTS),taskPeg(males & aBECTS),'s','MarkerEdgeColor',col(2,:),'MarkerSize',8,'MarkerFaceColor',col(2,:));
plot(age(males & rBECTS),taskPeg(males & rBECTS),'s','MarkerEdgeColor',col(3,:),'MarkerSize',8,'MarkerFaceColor',col(3,:));
plot(age(~males & hc),taskPeg(~males & hc),'*','MarkerEdgeColor',col(1,:),'MarkerSize',8,'MarkerFaceColor',col(1,:));
plot(age(~males & aBECTS),taskPeg(~males & aBECTS),'*','MarkerEdgeColor',col(2,:),'MarkerSize',8,'MarkerFaceColor',col(2,:));
plot(age(~males & rBECTS),taskPeg(~males & rBECTS),'*','MarkerEdgeColor',col(3,:),'MarkerSize',8,'MarkerFaceColor',col(3,:));

legend('Healthy M', 'Active M', 'Remission M','Healthy F','Active F','Remission F')
%legend('Healthy M','Active M', 'Remission M','Healthy F','Active F','Remission F')

xlabel('Age')
ylabel('Pegboard performance (s)')
set(gca,'FontSize',18)

figure; hold on;
plot(age(males & hc),taskPho(males & hc),'s','MarkerEdgeColor',col(1,:),'MarkerSize',8,'MarkerFaceColor',col(1,:));
plot(age(males & aBECTS),taskPho(males & aBECTS),'s','MarkerEdgeColor',col(2,:),'MarkerSize',8,'MarkerFaceColor',col(2,:));
plot(age(males & rBECTS),taskPho(males & rBECTS),'s','MarkerEdgeColor',col(3,:),'MarkerSize',8,'MarkerFaceColor',col(3,:));
plot(age(~males & hc),taskPho(~males & hc),'*','MarkerEdgeColor',col(1,:),'MarkerSize',8,'MarkerFaceColor',col(1,:));
plot(age(~males & aBECTS),taskPho(~males & aBECTS),'*','MarkerEdgeColor',col(2,:),'MarkerSize',8,'MarkerFaceColor',col(2,:));
plot(age(~males & rBECTS),taskPho(~males & rBECTS),'*','MarkerEdgeColor',col(3,:),'MarkerSize',8,'MarkerFaceColor',col(3,:));

legend('Healthy M', 'Active M', 'Remission M','Healthy F','Active F','Remission F')
%legend('Healthy M','Active M', 'Remission M','Healthy F','Active F','Remission F')

xlabel('Age')
ylabel('Phonemeic Awareness Score')
set(gca,'FontSize',18)

