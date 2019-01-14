%%%% Power barplots by lobe and by focus
%scale = 10^6; str= 'gamma (\muV)';
scale = 1;
dpower = nanmean(model.delta_power,2)*scale;
tpower = nanmean(model.theta_power,2)*scale;
apower = nanmean(model.alpha_power,2)*scale;
spower = nanmean(model.sigma_power,2)*scale;
bpower = nanmean(model.beta_power, 2)*scale;
gpower = nanmean(model.gamma_power,2)*scale;
total_power = dpower+tpower+apower+spower+bpower+gpower;
dpower = dpower./total_power;
tpower = tpower./total_power;
apower = apower./total_power;
spower = spower./total_power;
bpower = bpower./total_power;
gpower = gpower./total_power;

str_list = {'temporal','parietal','occipital','frontal','focus'};
nS = length(str_list);

GN = [];

figure;
for k = 1:6
    
    subplot(6,1,k);
    mean_data = zeros(nS,2);
    sem_data  = zeros(nS,2);
    GN = [];
    
    for i = 1:nS
        if i == nS
            [LN,RN] = find_subnetwork_coords(pc);
        else
            %%%% INCLUDE CODE TO REMOVE FOCUS FROM ANYTHING
            [LN,RN] = find_subnetwork_lobe(pc,str_list{i});
            [LNf,RNf] = find_subnetwork_coords(pc);
            LN = setdiff(LN,LNf);
            RN = setdiff(RN,RNf);
            GN = [GN; LN; RN];
        end
        
        if k == 1
            mean_data(i,1) = mean(dpower(LN));
            mean_data(i,2) = mean(dpower(RN));
            sem_data(i,1)  = std(dpower(LN))/sqrt(length(LN));
            sem_data(i,2)  = std(dpower(RN))/sqrt(length(RN));
            str='delta';
            %v =[0 2*10^-13];
        elseif k==2
            mean_data(i,1) = mean(tpower(LN));
            mean_data(i,2) = mean(tpower(RN));
            sem_data(i,1)  = std(tpower(LN))/sqrt(length(LN));
            sem_data(i,2)  = std(tpower(RN))/sqrt(length(RN));
            str = 'theta';
            %v =[0 6*10^-14];
        elseif k==3
            mean_data(i,1) = mean(apower(LN));
            mean_data(i,2) = mean(apower(RN));
            sem_data(i,1)  = std(apower(LN))/sqrt(length(LN));
            sem_data(i,2)  = std(apower(RN))/sqrt(length(RN));
            str = 'alpha';
            % v =[0 4*10^-14];
        elseif k==4
            mean_data(i,1) = mean(spower(LN));
            mean_data(i,2) = mean(spower(RN));
            sem_data(i,1)  = std(spower(LN))/sqrt(length(LN));
            sem_data(i,2)  = std(spower(RN))/sqrt(length(RN));
            str = 'sigma';
             %v =[0 2*10^-14];
        elseif k==5
            mean_data(i,1) = mean(bpower(LN));
            mean_data(i,2) = mean(bpower(RN));
            sem_data(i,1)  = std(bpower(LN))/sqrt(length(LN));
            sem_data(i,2)  = std(bpower(RN))/sqrt(length(RN));
            str= 'beta';
            %v =[0 1*10^-14];
        elseif k==6
            mean_data(i,1) = mean(gpower(LN));
            mean_data(i,2) = mean(gpower(RN));
            sem_data(i,1)  = std(gpower(LN))/sqrt(length(LN));
            sem_data(i,2)  = std(gpower(RN))/sqrt(length(RN));
            str= 'gamma';
            %v =[0 2*10^-16];
        end
    end
    
h1 = bar(mean_data);
if k ==6
set(gca, 'XTick', 1:nS, 'XTickLabel', str_list,'FontSize',12);
xtickangle(-45)
else
   set(gca, 'XTickLabel', [],'FontSize',12)
end
xData1 = h1(1).XData+h1(1).XOffset;
xData2 = h1(2).XData+h1(2).XOffset;
xData = sort([xData1 xData2],'ascend');
xData = reshape(xData,2,nS)';
hold on
errorbar(xData,mean_data,1.96.*sem_data,'b.')

ylabel(str)

text(2.5,1.5,model.patient_name,'FontSize',15)


end