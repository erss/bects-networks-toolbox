function plot_weighted_graph(patient_coordinates,weights )
% Plots a barplot of fc per label results and a uitable of how many elements
% were included in each calculation

xyz =patient_coordinates.coords(3:end,:);

figure;
GZ=graph(zeros(324,324));
p = plot(GZ,'XData',xyz(1,:),'YData',xyz(2,:), 'ZData',xyz(3,:),'MarkerSize',10);
p.NodeCData=weights;
[ LN,RN ] = find_subnetwork_str( patient_coordinates,'lateraloccipital');
labelnode(p,LN,'left lat occip')
labelnode(p,RN,'right lat occip')

[ LN,RN ] = find_subnetwork_coords( patient_coordinates);
labelnode(p,LN,'left SOZ')
labelnode(p,RN,'right SOZ')


view(-90,90)
colormap((parula))
colorbar
axis tight
set(gca,'xtick',[])
set(gca,'xticklabel',[])
set(gca,'ytick',[])
set(gca,'yticklabel',[])
box off



end
