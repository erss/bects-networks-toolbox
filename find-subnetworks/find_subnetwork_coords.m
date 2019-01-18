function [ LN,RN ] = find_subnetwork_coords( patient_coordinates)
% Returns indices of all nodes within the lower half of the pre- and post- 
% central gyrus. Outputs LN and RN correspond to nodes on the left and 
% right hemispheres respectively. 

xyz= patient_coordinates.coords;

xyz(2,:)= xyz(2,:)-ones(size(xyz(2,:)));
for i = 1:length(patient_coordinates.left_focus)
    LN(i) = find(xyz(2,:)==patient_coordinates.left_focus(i));
end

for i = 1:length(patient_coordinates.right_focus)
    RN(i) = find(xyz(2,:)==patient_coordinates.right_focus(i));
end

LN = sort(unique(LN));
LN= reshape(LN,[length(LN) 1]);
RN = sort(unique(RN));
RN= reshape(RN,[length(RN) 1]);
end

