%%% Load patient coords
pc= patient_coordinates_013;
xyz=pc.coords(3:end,:);
%%% Plot grid
G = graph(zeros(324,324),'OmitSelfLoops');
p = plot(G,'XData',xyz(1,:),'YData',xyz(2,:),...
    'ZData',xyz(3,:),'MarkerSize',4,'NodeColor',[0.3010, 0.7450, 0.9330]);
hold on;
%%% Plot Pre-Post CG
pc.hand ='left';
[ PreN,PostN ] = find_subnetwork_prepost( pc);
ix = [PreN;PostN];
nP = length(ix);
G = graph(zeros(nP,nP),'OmitSelfLoops');
p = plot(G,'XData',xyz(1,ix),'YData',xyz(2,ix),...
    'ZData',xyz(3,ix),'MarkerSize',5,'NodeColor','m');
p.NodeLabel = {};
pc.hand ='right';
[ PreN,PostN ] = find_subnetwork_prepost( pc);
ix = [PreN;PostN];
nP = length(ix);
G = graph(zeros(nP,nP),'OmitSelfLoops');
p = plot(G,'XData',xyz(1,ix),'YData',xyz(2,ix),...
    'ZData',xyz(3,ix),'MarkerSize',5,'NodeColor','m');
p.NodeLabel = {};
%%% Plot SOZ 
[ LN,RN] = find_subnetwork_coords( pc);
nL = length(LN);
nR = length(RN);

G = graph(zeros(nL,nL),'OmitSelfLoops');
p = plot(G,'XData',xyz(1,LN),'YData',xyz(2,LN),...
    'ZData',xyz(3,LN),'MarkerSize',5,'NodeColor','r');
p.NodeLabel = {};

G = graph(zeros(nR,nR),'OmitSelfLoops');
p = plot(G,'XData',xyz(1,RN),'YData',xyz(2,RN),...
    'ZData',xyz(3,RN),'MarkerSize',5,'NodeColor','r');
p.NodeLabel = {};



%%% Plot missing indices
% 1) Find missing indices
[LNp,RNp] = find_subnetwork_lobe( pc,'parietal');
[LNt,RNt] = find_subnetwork_lobe( pc,'temporal');
[LNo,RNo] = find_subnetwork_lobe( pc,'occipital');
[LNf,RNf] = find_subnetwork_lobe( pc,'frontal');
left_net = [LNp;LNt;LNo;LNf;LN];
right_net = [RNp;RNt;RNo;RNf;RN];
ii = 1:324;
ii([left_net;right_net])=[];
nM = length(ii);

% 1b) Check which are missing
labels =[ pc.LDL; pc.RDL];
labels(ii)
% 2) Plot missing indices

G = graph(zeros(nM,nM),'OmitSelfLoops');
p = plot(G,'XData',xyz(1,ii),'YData',xyz(2,ii),...
    'ZData',xyz(3,ii),'MarkerSize',5,'NodeColor','g');
p.NodeLabel = {};
