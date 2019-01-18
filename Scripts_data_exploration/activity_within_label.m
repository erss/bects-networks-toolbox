pc = patient_coordinates_020;
name = 'Healthy 20 - rest 06';
LDL = pc.LDL;
RDL = pc.RDL;
for i = 1:size(LDL,1)
    if isempty(LDL{i,1})
        LDL{i,1} = '';
    end
    
    if isempty(RDL{i,1})
        RDL{i,1} = '';
    end
end

str_list = {'insula','fusiform','parahippocampal','entorhinal','inferiortemporal',...
    'middletemporal','superiortemporal', 'temporalpole','transversetemporal', ... % TEMPORAL
    'supramarginal','isthmuscingulate','posteriorcingulate', ...
    'inferiorparietal', 'superiorparietal', ...% PARIETAL
    'paracentral','precuneus','postcentral', ...
    'lingual','pericalcarine','cuneus','lateraloccipital', ...                         % OCCIPTIAL
    'frontalpole','parsorbitalis', 'parstriangularis' ,'parsopercularis' ,'caudalanteriorcingulate', ... % FRONTAL
    'rostralanteriorcingulate','precentral', 'caudalmiddlefrontal','lateralorbitofrontal',...
    'medialorbitofrontal', 'rostralmiddlefrontal','superiorfrontal','focus'};
%%
nS = length(str_list);
mean_data = zeros(nS,2);
sem_data  = zeros(nS,2);
numElem   = zeros(nS,2);

GN = [];
for i =1:nS
    if i == nS
        [ LN,RN ] = find_subnetwork_coords(pc);
    else

        [LN, RN] = find_subnetwork_str(pc,str_list{i});
        GN = [GN; LN; RN];
    end
    
    %%%%% WHEN YOU COMPUTE THIS ARE YOU INCLUDED TIGHT DISTANCES? YES
    [dL, mL, ~,semL] = patient_activity( model,pc,LN);
    [dR, mR, ~,semR] = patient_activity( model,pc,RN);
    
    mean_data(i,1) = mL;
    mean_data(i,2) = mR;
    sem_data(i,1) = semL;
    sem_data(i,2) = semR;
    numElem(i,1) = length(LN);
    numElem(i,2) = length(RN);
    
    
end
%%
ii=1:324;
ii(GN)=[];
labels =[ pc.LDL; pc.RDL];
labels(ii)
%%
f=figure(1);


% create the data
% Create the column and row names in cell arrays
rnames = {'insula','fusi.','parahipp.','ent.','inf.temp.',...
    'mid.temp.','super.temp.', 'temp.pole','trans.temp.', ... % TEMPORAL
    'supramarg.','isthmuscing.','post.cing.', ...
    'inf.par.', 'sup.par.', ...% PARIETAL
    'paracentral','precun.','postcent.', ...
    'ling.','peri.car.','cuneus','lat.occip.', ...                         % OCCIPTIAL
    'front.pole','orbit.', 'triang.' ,'operc.' ,'caud.ant.cing.', ... % FRONTAL
    'rost.anter.cing.','precent.', 'caud.mid.front.','lat.orb.front.',...
    'med.orb.front.', 'rost.mid.front.','sup.front.','focus'};
cnames = {'L','R'};
% Create the uitable
t = uitable(f,'Data',numElem,'ColumnWidth',{10});
t.ColumnName = cnames;
t.RowName = str_list;
set(t,'units','normalized')
set(t,'position',[0 0 1 1])
%%
%subplot (1,5,1:4)
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
ylim([0 1])


%pos = get(subplot(1,5,5),'position');
%delete(subplot(1,5,5))
% figure(1)
% set(t,'units','normalized')
% set(t,'position',[pos(1) pos(2) pos(3)*2 pos(4)])
% 
% suptitle(name)

%%
weights = zeros(1,size(model.kC,1));
xyz =pc.coords(3:end,:);
for i =1:nS
    if i == nS
        [ LN,RN ] = find_subnetwork_coords(pc);
    else
        LN = find(strcmp(LDL,str_list{i}));
        RN = find(strcmp(RDL,str_list{i}));
        LN = sort(unique(LN));
        LN= reshape(LN,[length(LN) 1]);
        RN = sort(unique(RN))+162;
        RN= reshape(RN,[length(RN) 1]);
    end
    weights(LN) = mean_data(i,1);
    weights(RN) = mean_data(i,2);
end
figure;
GZ=graph(zeros(324,324));
p = plot(GZ,'XData',xyz(1,:),'YData',xyz(2,:), 'ZData',xyz(3,:),'MarkerSize',4,'NodeColor',[0.3010, 0.7450, 0.9330]);
p.NodeCData=weights;
view(-90,90)
colormap((jet))

axis tight



