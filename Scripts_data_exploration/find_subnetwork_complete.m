%%% Find activity in region of similar size

pc = patient_coordinates_020;
D = compute_nodal_distances(pc.coords(3:5,:));

range = [0.01, 0.4];

ni = 6;

[ LNp,RNp ] = find_subnetwork_lobe( pc,'parietal');
[ LNf,RNf ] = find_subnetwork_coords( patient_coordinates_020);
LN = setdiff(LNp,LNf);
RN = setdiff(RNp,RNf);

Dtest = D([LNf;RNf],:);
Dtest = Dtest <= 0.04;
[r,c]=find(Dtest==1);
c= unique(c);
LN = setdiff(LN,c);
RN = setdiff(RN,c);


Dp= D([LN;RN],[LN;RN]);
i= find(Dp>=0.04);
Dp(i)=NaN;


%Dym = triu(Dp,1) + transpose( triu(Dp,1));

[i,j]=find(isfinite(Dp));

Nodes = [i(end),j(end)];
t=1;
while length(Nodes)<ni
Dtemp = Dp(Nodes,:);
temp = sum(Dtemp,1);
i=find(isfinite(temp));
if isempty(i)
    [i,j]=find(isfinite(Dp));
    Nodes = [i(end-t),j(end-t)];
    t=t+1;
else
    Nodes = [Nodes i(1)];
end

end

PN = [LN;RN];
control_indices = PN(Nodes);

specs.A='raw';
specs.measure='coherence';
compute_patient_activity(model,patient_coordinates_020,specs,control_indices)

% Dp(Nodes,Nodes) ?= D(PN(Nodes),PN(Nodes))
% EdgeTable = table([i,j],'VariableNames',{'EndNodes'});
% G = graph(EdgeTable);

%%
%%% Find activity in region of similar size

pc = patient_coordinates_020;
D = compute_nodal_distances(pc.coords(3:5,:));

range = [0.01, 0.4];

ni = 6;

[ LNp,RNp ] = find_subnetwork_lobe( pc,'temporal');
[ LNf,RNf ] = find_subnetwork_coords( patient_coordinates_020);
LN = setdiff(LNp,LNf); % Parietal nodes excluding focus in left hem
RN = setdiff(RNp,RNf); % Parietal nodes excluding focus in right hem

%%%%% Left hemisphere

Dtest = D(LNf,1:162);
Dtest = Dtest <= 0.04;  % If entry is less than 0.04, it is too close to
                        % ... focus and is indicated by a 1
[r,c] = find(Dtest==1); % Find rows and columns for indices too close to focus
c = unique(c); 
LN = setdiff(LN,c);     % Remove nodes that are too close to any point in
                        % ... the focus
                        
                        
            
%%%% Random subset of nodes within 0.01, 0.4 of each other
%% Dsub = D(LN,LN);
r = randi(length(LN),[1 2]);
r= sort(r,'ascend')
i = LN(r(1)); 
j = LN(r(2));

while D(i,j) < 0.01 || D(i,j) > 0.03 % if distance is outside of range draw again
    r = randi(length(LN),[1 2]);
    r= sort(r,'ascend')
    i = LN(r(1)); 
    j = LN(r(2));
end

nodes = [i,j];  % save first

ni = 6; % size of network
%D = triu(D,1) + transpose( triu(D,1));
while length(nodes) < ni % while network is too small, keep adding nodes
    i = randi(length(LN),1);
    Dtemp= D(nodes,i);
    Dtemp = Dtemp > 0.04 | Dtemp < 0.01; % if distance is outside of range, 1
    if sum(Dtemp==0) %% all good
        nodes = [nodes, i];
        nodes = sort(nodes,'ascend')
    end
end
%%
xyz=patient_coordinates_020.coords(3:5,:);
G = graph(zeros(324,324),'OmitSelfLoops');
p = plot(G,'XData',xyz(1,:),'YData',xyz(2,:),...
        'ZData',xyz(3,:),'MarkerSize',6,'NodeColor',[0.3010, 0.7450, 0.9330]);
hold on 
G = graph(zeros(ni,ni),'OmitSelfLoops');
p = plot(G,'XData',xyz(1,nodes),'YData',xyz(2,nodes),...
    'ZData',xyz(3,nodes),'MarkerSize',10,'NodeColor','m','LineWidth',2,...
    'EdgeColor','k');
p.NodeLabel = {};

G = graph(zeros(length(LNf),length(LNf)),'OmitSelfLoops');
p = plot(G,'XData',xyz(1,LNf),'YData',xyz(2,LNf),...
    'ZData',xyz(3,LNf),'MarkerSize',10,'NodeColor','r','LineWidth',2,...
    'EdgeColor','k');
p.NodeLabel = {};


%%
%%% ATTEMPT 2
specs.A='raw';
specs.measure='coherence';
compute_patient_activity(model,patient_coordinates_020,specs,control_indices)

