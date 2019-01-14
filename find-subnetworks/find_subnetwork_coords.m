function [ LN,RN ] = find_subnetwork_coords( patient_coordinates)
%UNTITLED9 Summary of this function goes here
%   Detailed explanation goes here



% Choose subnetworks based on coordinates
xyz= patient_coordinates.coords;

xyz(2,:)= xyz(2,:)-ones(size(xyz(2,:)));
for i = 1:length(patient_coordinates.left_focus)
    LN(i) = find(xyz(2,:)==patient_coordinates.left_focus(i));
end

for i = 1:length(patient_coordinates.right_focus)
    RN(i) = find(xyz(2,:)==patient_coordinates.right_focus(i));
end

LN = sort(LN);
LN= reshape(LN,[length(LN) 1]);
RN = sort(RN);
RN= reshape(RN,[length(RN) 1]);
end
