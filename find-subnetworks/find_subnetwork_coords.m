function [ LN,RN ] = find_subnetwork_coords( patient_coordinates)
% Returns indices of all nodes within the lower half of the pre- and post-
% central gyrus. Outputs LN and RN correspond to nodes on the left and
% right hemispheres respectively.

xyz= patient_coordinates.coords;



for i = 1:length(patient_coordinates.left_focus)
    if length(find(xyz(2,:)==patient_coordinates.left_focus(i))) ==2
        temp = find(xyz(2,:)==patient_coordinates.left_focus(i));
        LN(i) =temp(1);
    elseif length(find(xyz(2,:)==patient_coordinates.left_focus(i))) ==1
        LN(i) = find(xyz(2,:)==patient_coordinates.left_focus(i));
    end
    
end

for i = 1:length(patient_coordinates.right_focus)
    
    if length(find(xyz(2,:)==patient_coordinates.right_focus(i))) ==2
        temp = find(xyz(2,:)==patient_coordinates.right_focus(i));
        RN(i) =temp(2);
    elseif length(find(xyz(2,:)==patient_coordinates.right_focus(i))) ==1
        RN(i) = find(xyz(2,:)==patient_coordinates.right_focus(i));
    end
end





LN = sort(unique(LN));
LN= reshape(LN,[length(LN) 1]);
RN = sort(unique(RN));
RN= reshape(RN,[length(RN) 1]);
end
