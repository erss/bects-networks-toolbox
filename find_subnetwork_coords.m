function [ LN,RN ] = find_subnetwork_coords( patient_coordinates)
%UNTITLED9 Summary of this function goes here
%   Detailed explanation goes here



% Choose subnetworks based on coordinates
xyz= patient_coordinates.coords;
for i = 1:length(patient_coordinates.left_focus)
    LN(i) = find(xyz(2,:)==patient_coordinates.left_focus(i));
end

for i = 1:length(patient_coordinates.right_focus)
    RN(i) = find(xyz(2,:)==patient_coordinates.right_focus(i));
end

LN = sort(LN);
RN = sort(RN);
end

