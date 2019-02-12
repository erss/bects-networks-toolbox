function plot_power_per_label(model,patient_coordinates)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

band = [10,15];% sigma
% band = [4, 8]; % theta
% band = [15,30]; % beta
% List of all desikan labels and focus
str_list = {'insula','fusiform','parahippocampal','entorhinal', ...
    'inferiortemporal','middletemporal','superiortemporal',...
    'temporalpole','transversetemporal', ... % TEMPORAL
    'supramarginal','isthmuscingulate','posteriorcingulate', ...
    'inferiorparietal', 'superiorparietal', ...% PARIETAL
    'paracentral','precuneus','postcentral', ...
    'lingual','pericalcarine','cuneus','lateraloccipital', ... % OCCIPTIAL
    'frontalpole','parsorbitalis', 'parstriangularis' ,...
    'parsopercularis' ,'caudalanteriorcingulate', ... % FRONTAL
    'rostralanteriorcingulate','precentral', 'caudalmiddlefrontal',...
    'lateralorbitofrontal','medialorbitofrontal', 'rostralmiddlefrontal',...
    'superiorfrontal','focus'};

[mean_data, sem_data, numElem] = compute_power_per_label( model,patient_coordinates,band,str_list );


nS = length(str_list);
% %  Create the uitable
% f=figure;
% cnames = {'L','R'};
% t = uitable(f,'Data',numElem,'ColumnWidth',{10});
% t.ColumnName = cnames;
% t.RowName = str_list;
% set(t,'units','normalized')
% set(t,'position',[0 0 1 1])

% Plot barplot
figure;
h1 = bar(mean_data);
set(gca, 'XTick', 1:nS, 'XTickLabel', str_list);
xtickangle(-45)
xData1 = h1(1).XData+h1(1).XOffset;
xData2 = h1(2).XData+h1(2).XOffset;
xData = sort([xData1 xData2],'ascend');
xData = reshape(xData,2,nS)';
hold on
errorbar(xData,mean_data,1.96.*sem_data,'b.')
title([model.patient_name],'FontSize',20)
%ylim([0 2e-20])
ylim([0 0.02])
legend('Left', 'Right')

end

