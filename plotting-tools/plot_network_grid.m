function plot_network_grid( A, patient_coordinates,varargin)
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here

if nargin ==2
    figure;
elseif ishandle(varargin{1}(1))
    ax = varargin{1};
    set(gcf, 'CurrentAxes', ax)
end

% [ LN,RN] = find_subnetwork_coords( patient_coordinates);
% Aleft = A(LN,LN,:);
% Aright = A(RN,RN,:);

%%%% SFN changes
[ PreN,PostN ] = find_subnetwork_prepost( patient_coordinates);
N= [PreN;PostN];
App = A([PreN;PostN],[PreN;PostN],:);
App(1:length(PreN),1:length(PreN),:) = zeros(length(PreN));
App(length(PreN)+1:end,length(PreN)+1:end,:) = zeros(length(PostN));
xyz =patient_coordinates.coords(3:end,:);


j=1;

G = graph(zeros(324,324),'OmitSelfLoops');
p = plot(G,'XData',xyz(1,:),'YData',xyz(2,:),...
    'ZData',xyz(3,:),'MarkerSize',4,'NodeColor',[0.3010, 0.7450, 0.9330]);
%view(90.1,90)
axis tight
box off
ax = gca;
ax.Visible= 'off';
hold on;

% G = graph(Aleft(:,:,j),'OmitSelfLoops');
% p = plot(G,'XData',xyz(1,LN),'YData',xyz(2,LN),...
%     'ZData',xyz(3,LN),'MarkerSize',5,'NodeColor','r');
% p.NodeLabel = {};
% 
% G = graph(Aright(:,:,j),'OmitSelfLoops');
% p = plot(G,'XData',xyz(1,RN),'YData',xyz(2,RN),...
%     'ZData',xyz(3,RN),'MarkerSize',5,'NodeColor','g');
% p.NodeLabel = {};

%%%% SFN changes

G = graph(App(:,:,j),'OmitSelfLoops');
p = plot(G,'XData',xyz(1,N),'YData',xyz(2,N),...
    'ZData',xyz(3,N),'LineWidth',1,'EdgeColor','k','MarkerSize',7,'NodeColor','b');
p.NodeLabel = {};

G = graph(zeros(length(PreN)),'OmitSelfLoops');
p = plot(G,'XData',xyz(1,PreN),'YData',xyz(2,PreN),...
    'ZData',xyz(3,PreN),'MarkerSize',7,'NodeColor','r');
p.NodeLabel = {};


hold off
%   view(90.1,90)
view(-110,2)
drawnow



end

