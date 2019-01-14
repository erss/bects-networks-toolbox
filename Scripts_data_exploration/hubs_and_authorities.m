pc=patient_coordinates_006;
A=nanmean(model.net_coh,3);
MAuthority = transpose(A)*A;
MHubs = A*transpose(A);
G= graph(A);
[evec, eval]=eig(MAuthority);
pc_authority=evec(:,end);
[evec]=eig(MHubs);
pc_hub=evec(:,end);
xyz =pc.coords(3:end,:);
[evec, eval]=eig(A);
pc_a=evec(:,end);
% G1= graph(MAuthority);
% G2= graph(MHubs);
% hub_ranks = centrality(G2,'eigenvector');
% auth_ranks = centrality(G1,'eigenvector');
% G.Nodes.Hubs = hub_ranks;
% G.Nodes.Authorities = auth_ranks;
for i = 1:324
   centAuthority(i) = sum(A(:,i).*pc_authority);
   centHub(i) = sum(A(:,i).*pc_hub);
   cent(i) = sum(A(:,i).*pc_a);
end
[ LN,RN ] = find_subnetwork_coords( pc);
%%
figure;
subplot 131
GZ=graph(zeros(324,324));
GLN = graph(A(LN,LN));
GRN = graph(A(RN,RN));
p = plot(GZ,'XData',xyz(1,:),'YData',xyz(2,:), 'ZData',xyz(3,:),'MarkerSize',4,'NodeColor',[0.3010, 0.7450, 0.9330]);
p.NodeCData=centAuthority;
hold on;
p1=plot(GLN,'XData',xyz(1,LN),'YData',xyz(2,LN),'ZData',xyz(3,LN),'LineWidth',1,'EdgeColor','k');
p2=plot(GRN,'XData',xyz(1,RN),'YData',xyz(2,RN),'ZData',xyz(3,RN),'LineWidth',1,'EdgeColor','k');
p1.NodeLabel={};
p2.NodeLabel={};
p1.NodeCData=centAuthority([LN]);
p2.NodeCData=centAuthority([RN]);
view(-90,90)
axis square
subplot 132
GZ=graph(zeros(324,324));
p = plot(GZ,'XData',xyz(1,:),'YData',xyz(2,:), 'ZData',xyz(3,:),'MarkerSize',4,'NodeColor',[0.3010, 0.7450, 0.9330]);
p.NodeCData=centHub;
view(-90,90)
axis square

subplot 133
GZ=graph(zeros(324,324));
p = plot(GZ,'XData',xyz(1,:),'YData',xyz(2,:), 'ZData',xyz(3,:),'MarkerSize',4,'NodeColor',[0.3010, 0.7450, 0.9330]);
p.NodeCData=cent;
view(-90,90)
axis square

%%
figure;
bcc = centrality(G,'betweenness');
figure;
ccc = centrality(G,'closeness');
figure;
ecc = centrality(G,'eigenvector');
GZ=graph(zeros(324,324));
subplot 141
p = plot(GZ,'XData',xyz(1,:),'YData',xyz(2,:), 'ZData',xyz(3,:),'MarkerSize',4,'NodeColor',[0.3010, 0.7450, 0.9330]);
p.NodeCData=bcc;
view(-90,90)
axis square
subplot 142
p = plot(GZ,'XData',xyz(1,:),'YData',xyz(2,:), 'ZData',xyz(3,:),'MarkerSize',4,'NodeColor',[0.3010, 0.7450, 0.9330]);
p.NodeCData=ccc;
view(-90,90)
axis square
subplot 143
p = plot(GZ,'XData',xyz(1,:),'YData',xyz(2,:), 'ZData',xyz(3,:),'MarkerSize',4,'NodeColor',[0.3010, 0.7450, 0.9330]);
p.NodeCData=ecc;
view(-90,90)
axis square
subplot 144
p = plot(GZ,'XData',xyz(1,:),'YData',xyz(2,:), 'ZData',xyz(3,:),'MarkerSize',4,'NodeColor',[0.3010, 0.7450, 0.9330]);
p.NodeCData=pc_a;
view(-90,90)
axis square

figure;
p = plot(GZ,'XData',xyz(1,:),'YData',xyz(2,:), 'ZData',xyz(3,:),'MarkerSize',4,'NodeColor',[0.3010, 0.7450, 0.9330]);
p.NodeCData=pc_a;
view(-90,90)
axis square