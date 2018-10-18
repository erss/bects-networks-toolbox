%%% Compute functional connectivty for nodes w/i pre and post central gyrus
patient = 'pBECTS007_sleep05';
OUTFIGPATH = strcat('~/Desktop/bects_data/plots/',patient);
% load appropriate coordinate space
coords = pBECTS007_sourcespace_324pts;

% find indices of precentral gyrus
indices_precentral_left = find(strcmp(left_desikan_label,'precentral'));
indices_precentral_right = find(strcmp(right_desikan_label,'precentral')) + 162;

% find indices of postcentral gyrus
indices_postcentral_left = find(strcmp(left_desikan_label,'postcentral'));
indices_postcentral_right = find(strcmp(right_desikan_label,'postcentral')) + 162;


% A is matrix node x node x time
%%% Determine sourcespace coordinates
A; 
% Left hemisphere
left_ntwk = [indices_precentral_left;indices_postcentral_left];
Aleft = A(left_ntwk,left_ntwk,:);

% right hemisphere
right_ntwk = [indices_precentral_right;indices_postcentral_right];
Aright = A(right_ntwk,right_ntwk,:);

xyz_left   = [coords(3,1:162); ...
                        coords(4,1:162); ...
                        coords(5,1:162)];
xyz_right = [coords(3,163:end); ...
                         coords(4,163:end); ...
                         coords(5,163:end)];
xyz = [xyz_left xyz_right];
%% Plot averaged connectivity over time in coordinate space
figure;

G = graph(zeros(324,324),'OmitSelfLoops');
p = plot(G,'XData',xyz(1,:),'YData',xyz(2,:),...
    'ZData',xyz(3,:),'MarkerSize',5,'NodeColor',[0.3010, 0.7450, 0.9330]);
hold on;

% Left hemisphere
left_ntwk = [indices_precentral_left;indices_postcentral_left];
Aleft = A(left_ntwk,left_ntwk,:);
G = graph(mean(Aleft,3),'OmitSelfLoops');
p = plot(G,'XData',xyz(1,left_ntwk),'YData',xyz(2,left_ntwk),...
    'ZData',xyz(3,left_ntwk),'MarkerSize',5,'NodeColor','r');
p.NodeLabel = {};
hold on;

% Right hemisphere

right_ntwk = [indices_precentral_right;indices_postcentral_right];
Aright = A(right_ntwk,right_ntwk,:);

G = graph(mean(Aright,3),'OmitSelfLoops');
p = plot(G,'XData',xyz(1,right_ntwk),'YData',xyz(2,right_ntwk),...
    'ZData',xyz(3,right_ntwk),'MarkerSize',5,'NodeColor','g');
p.NodeLabel = {};
view(90.1,90)
box off
 ax = gca;
 ax.Visible= 'off';


% %%
% figure;
% 
% G = graph(zeros(324,324),'OmitSelfLoops');
% p = plot(G,'XData',xyz(1,:),'YData',xyz(2,:),...
%     'ZData',xyz(3,:),'MarkerSize',5,'NodeColor',[0.3010, 0.7450, 0.9330]);
% hold on;
% across = [left_ntwk; right_ntwk];
% Acorps = mean(A(across,across,:),3);
% Acorps(1:21,1:21) = zeros(21,21);
% Acorps(22:end,22:end) = zeros(16,16);
% G = graph(Acorps,'OmitSelfLoops');
% p = plot(G,'XData',xyz(1,across),'YData',xyz(2,across),...
%     'ZData',xyz(3,across),'MarkerSize',5,'NodeColor','g');
% p.NodeLabel = {};
% view(90.1,90)
% box off
%  ax = gca;
%  ax.Visible= 'off';

%[az,el] = view

%% Compute and plot average FC in network for each point in time.
clear f
clear c
clear g
clear fc_left
clear fc_right
clear fc_global
for i = 1:size(Aleft,3)
    
    f  = Aleft(:,:,i);    % grab each network at each point in time
    c  = Aright(:,:,i);
    g  = A(:,:,i);
    fc_left(i)    = mean(f(:));  % compute and store mean connectivity for
    fc_right(i)  = mean(c(:));  % ... each network
    fc_global(i)   = mean(g(:));

end
model.taxis = 1:length(fc_left); %model.taxis%1:length(fc_left);
% plot connectivity over time
figure;
plot(model.taxis,fc_left,'r');
hold on
plot(model.taxis,fc_right,'g')
plot(model.taxis,fc_global,'k')
title('Density','FontSize',16)
ylim([0 1])
box off

% compute + plot mean connectivity
[mn bds ]=normal_stats(fc_left);
mn1 = mean(fc_right);
mn2 = mean(fc_global);

plot([model.taxis(1) model.taxis(end)],[mn mn],'-r')
plot([model.taxis(1) model.taxis(end)],[bds(1) bds(1)],'--r')
plot([model.taxis(1) model.taxis(end)],[bds(2) bds(2)],'--r')

[mn1 bds ]=normal_stats(fc_right);
plot([model.taxis(1) model.taxis(end)],[mn1 mn1],'-g')
plot([model.taxis(1) model.taxis(end)],[bds(1) bds(1)],'--g')
plot([model.taxis(1) model.taxis(end)],[bds(2) bds(2)],'--g')
[mn2 bds ]=normal_stats(fc_global);
plot([model.taxis(1) model.taxis(end)],[mn2 mn2],'-k')
plot([model.taxis(1) model.taxis(end)],[bds(1) bds(1)],'--k')
plot([model.taxis(1) model.taxis(end)],[bds(2) bds(2)],'--k')
h=legend({'Left','Right','Global'},'FontSize',14);
xlabel(['Time (s)'],'FontSize',15)
%% Save and print results

fprintf(['left nodes:    ' num2str(size(Aleft,1)) '\n'])
fprintf(['right nodes:   ' num2str(size(Aright,1)) '\n'])
fprintf(['left density:  ' num2str(mn) '\n'])
fprintf(['right density: ' num2str(mn1) '\n'])
fprintf(['global density:' num2str(mn2) '\n'])

%saveas(figure(1),[OUTFIGPATH '_avg_network.png']);
%saveas(figure(2),[OUTFIGPATH '_density.png']);
%close all


    