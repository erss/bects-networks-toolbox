function plot_adj_matrix_on_grid( A, patient_coordinates)
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here

    
% Network movie
%OUTVIDPATH = strcat('~/Desktop/',patient,'.avi');
OUTVIDPATH = '/Users/erss/Documents/MATLAB/BECTS-networks';
% A1=A;
% for i = 1:size(A,3)
%     Atemp=A1(:,:,i);
%     if sum(isnan(Atemp(:))) ~=0
%         A(:,:,i)=[];
%     end
% end
[ LN,RN] = find_subnetwork_coords( patient_coordinates);
Aleft = A(LN,LN,:);
Aright = A(RN,RN,:);
xyz =patient_coordinates.coords(3:end,:);

v = VideoWriter(OUTVIDPATH);
v.FrameRate=15;
open(v);
h = figure;

for j = 1:size(A,3)
  
    G = graph(zeros(324,324),'OmitSelfLoops');
    p = plot(G,'XData',xyz(1,:),'YData',xyz(2,:),...
        'ZData',xyz(3,:),'MarkerSize',6,'NodeColor',[0.3010, 0.7450, 0.9330]);
    view(90.1,90)
    axis tight
    box off
    ax = gca;
    ax.Visible= 'off';
    hold on;
    
    G = graph(Aleft(:,:,j),'OmitSelfLoops');
    p = plot(G,'XData',xyz(1,LN),'YData',xyz(2,LN),...
        'ZData',xyz(3,LN),'MarkerSize',10,'NodeColor','r','LineWidth',2,...
        'EdgeColor','k');
    p.NodeLabel = {};
    
    G = graph(Aright(:,:,j),'OmitSelfLoops');
    p = plot(G,'XData',xyz(1,RN),'YData',xyz(2,RN),...
        'ZData',xyz(3,RN),'MarkerSize',10,'NodeColor','g','LineWidth',2, ...
         'EdgeColor','k');
    p.NodeLabel = {};
    
    hold off
 %   view(90.1,90)
    view(-107,14)
    drawnow
    
    F = getframe(h);
    image = F.cdata;
    writeVideo(v,image(1:end,1:end,:));
end
close(v)

end

