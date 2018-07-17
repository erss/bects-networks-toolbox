function [ LN,RN ] = subnetworks( patient_coordinates)
%UNTITLED9 Summary of this function goes here
%   Detailed explanation goes here

%% Choose subnetworks based on name
% LDL = patient_coordinates.LDL;
% RDL = patient_coordinates.RDL;
% indices_precentral_left   = find(strcmp(LDL,'precentral'));
% indices_precentral_right  = find(strcmp(RDL,'precentral')) + 162;
% indices_postcentral_left  = find(strcmp(LDL,'postcentral'));
% indices_postcentral_right = find(strcmp(RDL,'postcentral')) + 162;
% 
% 
% LN = [indices_precentral_left;indices_postcentral_left];
% RN = [indices_precentral_right;indices_postcentral_right];

%% Choose subnetworks based on name
LDL = patient_coordinates.LDL;
RDL = patient_coordinates.RDL;
for i = 1:size(LDL,1)
    if isempty(LDL{i,1})
        LDL{i,1} = '';
    end
    
    if isempty(RDL{i,1})
        RDL{i,1} = '';
    end
end
LN  = find(contains(LDL,'temporal'));
RN  = find(contains(RDL,'temporal')) + 162;


%% Choose subnetworks based on coordinates
% xyz= patient_coordinates.coords;
% for i = 1:length(patient_coordinates.left_focus)
%     LN(i) = find(xyz(2,:)==patient_coordinates.left_focus(i));
% end
% 
% for i = 1:length(patient_coordinates.right_focus)
%     RN(i) = find(xyz(2,:)==patient_coordinates.right_focus(i));
% end

end

