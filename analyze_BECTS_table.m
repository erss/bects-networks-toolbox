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
taskPho       = nan(1,length(patient_names));   % performance of phonemic awareness task
cohPrePost    = nan(1,length(patient_names));   % coherence in pre post CG
cohSOZ        = nan(1,length(patient_names));   % coherence in SOZ mean of L and R
cohLang       = nan(1,length(patient_names));   % coherence from left SOZ to left STL
cohAcross     = nan(1,length(patient_names));   % coherence from left SOZ to right SOZ
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

    taskPho(i)     = T.PhonoAwareRaw(chunk(1));
    cohPrePost(i)  = nanmean(T.prepostSOZ(chunk));
    cohSOZ(i)      = nanmean([nanmean(T.leftSOZ(chunk)),nanmean(T.rightSOZ(chunk))]);
    cohLang(i)     = nanmean(T.leftSOZ_stl(chunk));
    cohAcross(i)   = nanmean(T.acrossSOZ(chunk));
    
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

temp = char(T.patient_name);
temp = temp(:,end-1:end);
plabels = unique(cellstr(temp))

%% 1) Plot Pegboard Task Performance vs sigma coherence in PrePost CG -- RIGHT HAND ONLY
mdl = fitglm(cohPrePost(rightHand),taskPeg(rightHand))
b   = mdl.Coefficients.Estimate(1);
m   = mdl.Coefficients.Estimate(2);

figure; hold on;
plot(cohPrePost(rightHand & hc),taskPeg(rightHand & hc),'sb','MarkerSize',8)

plot(cohPrePost(rightHand & aBECTS),taskPeg(rightHand & aBECTS),'sr','MarkerSize',8)
plot(cohPrePost(rightHand & rBECTS),taskPeg(rightHand & rBECTS),'sm','MarkerSize',8)
plot(cohPrePost(~rightHand & hc),taskPeg(~rightHand & hc),'*b','MarkerSize',8)
plot(cohPrePost(~rightHand & aBECTS),taskPeg(~rightHand & aBECTS),'*r','MarkerSize',8)
plot(cohPrePost(~rightHand & rBECTS),taskPeg(~rightHand & rBECTS),'*m','MarkerSize',8)
labelpoints(cohPrePost,taskPeg,plabels)
xaxis = min(cohPrePost):.001:max(cohPrePost);
yaxis = b+m.*xaxis;
plot(xaxis,yaxis,'--','LineWidth',2)
legend('Healthy RH','Active RH','Remission RH','Healthy LH','Active LH',...
    'Remission LH',['y = ' num2str(m) 'x +' num2str(b), ', p=' num2str(mdl.Coefficients.pValue(2))])
xlabel('Sigma Coherence in Pre Post CG')
ylabel('Time to complete task (s)')
set(gca,'FontSize',18)
%% 2) Plot Phoneme Task Performance vs sigma coherence in Left SOZ to STL -- RIGHT HAND ONLY
mdl=fitglm(cohLang(rightHand),taskPho(rightHand))
b=mdl.Coefficients.Estimate(1);
m=mdl.Coefficients.Estimate(2);

figure; hold on;
plot(cohLang(rightHand & hc),taskPho(rightHand & hc),'sb','MarkerSize',8)
plot(cohLang(rightHand & aBECTS),taskPho(rightHand & aBECTS),'sm','MarkerSize',8)
plot(cohLang(rightHand & rBECTS),taskPho(rightHand & rBECTS),'sr','MarkerSize',8)
plot(cohLang(~rightHand & hc),taskPho(~rightHand & hc),'*b','MarkerSize',8)
plot(cohLang(~rightHand & aBECTS),taskPho(~rightHand & aBECTS),'*m','MarkerSize',8)
plot(cohLang(~rightHand & rBECTS),taskPho(~rightHand & rBECTS),'*r','MarkerSize',8)
xaxis = min(cohLang):.001:max(cohLang);
yaxis = b+m.*xaxis;
plot(xaxis,yaxis,'--','LineWidth',2)
plot(xaxis,yaxis,'--','LineWidth',2)
legend('Healthy RH','Active RH','Remission RH','Healthy LH','Active LH',...
    'Remission LH',['y = ' num2str(m) 'x +' num2str(b), ', p=' num2str(mdl.Coefficients.pValue(2))])
xlabel('Sigma Coherence of Left SOZ to STL')
ylabel('Raw Phono Awareness Score')
set(gca,'FontSize',18)


%% 3) 

figure; 
subplot 121
barplot({'Active','Remission','Healthy'},cohPrePost(aBECTS),cohPrePost(rBECTS),cohPrePost(hc))
ylabel(' Sigma Coherence in Pre Post CG')
axis square

subplot 122
barplot({'Active','Remission','Healthy'},taskPeg(aBECTS),taskPeg(rBECTS),taskPeg(hc))
ylabel('Pegboard Task Perforamce (seconds)')
axis square


figure;
subplot 121
barplot({'Active','Remission','Healthy'},cohLang(aBECTS),cohLang(rBECTS),cohLang(hc))
ylabel('Sigma Coherence in Left SOZ to left STL')
axis square

subplot 122
barplot({'Active','Remission','Healthy'},taskPho(aBECTS),taskPho(rBECTS),taskPho(hc))
ylabel('Phonemic Awareness Task Perforamce Score')
axis square

figure;
subplot 121
barplot({'Active','Remission','Healthy'},cohSOZ(aBECTS),cohSOZ(rBECTS),cohSOZ(hc))
ylabel('Sigma Coherence in L/R SOZ')
axis square

subplot 122
barplot({'Active','Remission','Healthy'},cohAcross(aBECTS),cohAcross(rBECTS),cohAcross(hc))
ylabel('Sigma Coherence from L to R SOZ')
axis square


%%
figure;
barplot({'Active - Spiking','Active - Not Spiking','Healthy'},...
    spiking,nonspiking,hcsoz );
ylabel('Sigma Coherence in SOZ')
axis square


%%
figure; hold on;
plot(age(males & hc),cohSOZ(males & hc),'sb','MarkerSize',8);
plot(age(males & aBECTS),cohSOZ(males & aBECTS),'sr','MarkerSize',8);
plot(age(males & rBECTS),cohSOZ(males & rBECTS),'sm','MarkerSize',8);
plot(age(~males & hc),cohSOZ(~males & hc),'*b','MarkerSize',8);
plot(age(~males & aBECTS),cohSOZ(~males & aBECTS),'*r','MarkerSize',8);
plot(age(~males & rBECTS),cohSOZ(~males & rBECTS),'*m','MarkerSize',8);
legend('Healthy M', 'Active M', 'Remission M','Healthy F','Active F','Remission F')
xlabel('age')
ylabel('sigma coherence in L/R SOZ')
set(gca,'FontSize',18)

%%
idx=isnan(affectedAndDom);

mdl = fitglm(cohPrePost(affectedAndDom==1),taskPeg(affectedAndDom==1))
b   = mdl.Coefficients.Estimate(1);
m   = mdl.Coefficients.Estimate(2);

figure; hold on;
plot(cohPrePost( hc),taskPeg( hc),'sb','MarkerSize',8)
plot(cohPrePost(affectedAndDom==1 & aBECTS),taskPeg(affectedAndDom==1 & aBECTS),'sr','MarkerSize',8)
plot(cohPrePost(affectedAndDom==1 & rBECTS),taskPeg(affectedAndDom==1 & rBECTS),'sm','MarkerSize',8)
plot(cohPrePost(affectedAndDom==0& aBECTS),taskPeg(affectedAndDom==0 & aBECTS),'*r','MarkerSize',8)
plot(cohPrePost(affectedAndDom==0 & rBECTS),taskPeg(affectedAndDom==0 & rBECTS),'*m','MarkerSize',8)
plot(cohPrePost(isnan(affectedAndDom) & rBECTS),taskPeg(isnan(affectedAndDom) & rBECTS),'*c ','MarkerSize',8)
xaxis = min(cohPrePost):.001:max(cohPrePost);
yaxis = b+m.*xaxis;
plot(xaxis,yaxis,'--','LineWidth',2)
plot(xaxis,yaxis,'--','LineWidth',2)
legend('Healthy','Active Ips','Remission Ips','Active Contr','Remission Contr',...
    'Not reported Remission',['y = ' num2str(m) 'x +' num2str(b), 'p=' num2str(mdl.Coefficients.pValue(2))])

xlabel('Sigma Coherence in Pre Post CG')
ylabel('Time to complete task (s)')
set(gca,'FontSize',18)
%%
