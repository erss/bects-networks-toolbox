pc         = patient_coordinates_007;
model      = model_sigma_two;


A          = nanmean(model.kC,3);
Atemp = A;
for i = 1:size(A,3)
    Atemp(:,:,i) = triu(A(:,:,i)) + transpose(triu(A(:,:,i)));
end
A = Atemp;


xyz        = pc.coords(3:end,:);
MAuthority = transpose(A)*A;
MHubs      = A*transpose(A);
G          = graph(A);

%%%% Compute eigenvalues and eigenvectors for authority matrix
[evec]       = eig(MAuthority);
pc_authority = evec(:,end);

%%%% Compute eigenvalues and eigenvectors for hubs matrix
[evec] = eig(MHubs);
pc_hub = evec(:,end);

%%%% Compute eigenvalues and eigenvectors for averaged network
[evec, eval] = eig(A);
pc_a         = evec(:,end);



% G1= graph(MAuthority);
% G2= graph(MHubs);
% hub_ranks = centrality(G2,'eigenvector');
% auth_ranks = centrality(G1,'eigenvector');
% G.Nodes.Hubs = hub_ranks;
% G.Nodes.Authorities = auth_ranks;


for i = 1:324
   centAuthority(i) = sum(A(:,i).*pc_authority);
   centHub(i)       = sum(A(:,i).*pc_hub);
   cent(i)          = sum(A(:,i).*pc_a);
end

[ LN,RN ] = find_subnetwork_coords( pc);
%% Plot nodes by eigenvector entry
figure;
subplot 131
plot(diag(eval),'o')
ylabel('eigenvalues')
xlabel('indices')
title('Evals')
set(gca,'FontSize',16)
axis square

subplot 132
plot(pc_a)
title('Principal evec')
set(gca,'FontSize',16)
axis square

subplot 133
GZ=graph(zeros(324,324));
GLN = graph(A(LN,LN));
GRN = graph(A(RN,RN));
p = plot(GZ,'XData',xyz(1,:),'YData',xyz(2,:), 'ZData',xyz(3,:),'MarkerSize',4,'NodeColor',[0.3010, 0.7450, 0.9330]);
p.NodeCData=pc_a;
hold on;
p1=plot(GLN,'XData',xyz(1,LN),'YData',xyz(2,LN),'ZData',xyz(3,LN),'LineWidth',1,'EdgeColor','k');
p2=plot(GRN,'XData',xyz(1,RN),'YData',xyz(2,RN),'ZData',xyz(3,RN),'LineWidth',1,'EdgeColor','k');
p1.NodeLabel={};
p2.NodeLabel={};
p1.NodeCData=pc_a([LN]);
p2.NodeCData=pc_a([RN]);
view(-90,90)
axis square
title('Nodes Colored by Eigenvector Entry')

suptitle('pBECTS007, averaged raw')
%% 
% figure;
% subplot 131
% GZ=graph(zeros(324,324));
% GLN = graph(A(LN,LN));
% GRN = graph(A(RN,RN));
% p = plot(GZ,'XData',xyz(1,:),'YData',xyz(2,:), 'ZData',xyz(3,:),'MarkerSize',4,'NodeColor',[0.3010, 0.7450, 0.9330]);
% p.NodeCData=centAuthority;
% hold on;
% p1=plot(GLN,'XData',xyz(1,LN),'YData',xyz(2,LN),'ZData',xyz(3,LN),'LineWidth',1,'EdgeColor','k');
% p2=plot(GRN,'XData',xyz(1,RN),'YData',xyz(2,RN),'ZData',xyz(3,RN),'LineWidth',1,'EdgeColor','k');
% p1.NodeLabel={};
% p2.NodeLabel={};
% p1.NodeCData=centAuthority([LN]);
% p2.NodeCData=centAuthority([RN]);
% view(-90,90)
% axis square
% subplot 132
% GZ=graph(zeros(324,324));
% p = plot(GZ,'XData',xyz(1,:),'YData',xyz(2,:), 'ZData',xyz(3,:),'MarkerSize',4,'NodeColor',[0.3010, 0.7450, 0.9330]);
% p.NodeCData=centHub;
% view(-90,90)
% axis square
% 
% subplot 133

figure;
GZ=graph(zeros(324,324));
p = plot(GZ,'XData',xyz(1,:),'YData',xyz(2,:), 'ZData',xyz(3,:),'MarkerSize',4,'NodeColor',[0.3010, 0.7450, 0.9330]);
p.NodeCData=cent;
view(-90,90)
axis square
title('Evec centrality my code')

%%

%%% Compute all measures of centrality
G          = graph(A);
bcc = centrality(G,'betweenness');
ccc = centrality(G,'closeness');
ecc = centrality(G,'eigenvector');
figure;
GZ=graph(zeros(324,324));
subplot 131
p = plot(GZ,'XData',xyz(1,:),'YData',xyz(2,:), 'ZData',xyz(3,:),'MarkerSize',4,'NodeColor',[0.3010, 0.7450, 0.9330]);
% hold on
% p1=plot(GLN,'XData',xyz(1,LN),'YData',xyz(2,LN),'ZData',xyz(3,LN),'LineWidth',1,'EdgeColor','k');
% p2=plot(GRN,'XData',xyz(1,RN),'YData',xyz(2,RN),'ZData',xyz(3,RN),'LineWidth',1,'EdgeColor','k');
% p1.NodeLabel={};
% p2.NodeLabel={};
p.NodeCData=bcc;
view(-90,90)
axis square
title('Betweenness')
subplot 132
p = plot(GZ,'XData',xyz(1,:),'YData',xyz(2,:), 'ZData',xyz(3,:),'MarkerSize',4,'NodeColor',[0.3010, 0.7450, 0.9330]);
p.NodeCData=ccc;
view(-90,90)
axis square
title('Closeness')
subplot 133
p = plot(GZ,'XData',xyz(1,:),'YData',xyz(2,:), 'ZData',xyz(3,:),'MarkerSize',4,'NodeColor',[0.3010, 0.7450, 0.9330]);
p.NodeCData=ecc;
view(-90,90)
axis square
title('Eigenvector')
suptitle('pBECTS007 colored by centrality (averaged raw)')


%% Make 3D plot
A = model.kC;
Atemp = A;
for i = 1:size(A,3)
    Atemp(:,:,i) = triu(A(:,:,i)) + transpose(triu(A(:,:,i)));
end
A = Atemp;

plot_adj_matrix_on_grid_pca(A,pc);

