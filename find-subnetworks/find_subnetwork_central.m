function [ LN,RN ] = find_subnetwork_central( patient_coordinates)
% Returns indices of all nodes in the pre and post central gyrus. Outputs
% LN and RN correspond to nodes on the left and right hemispheres respectively. 

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

indices_precentral_left   = find(strcmp(LDL,'precentral'));
indices_precentral_right  = find(strcmp(RDL,'precentral')) + 162;

indices_postcentral_left  = find(strcmp(LDL,'postcentral'));
indices_postcentral_right = find(strcmp(RDL,'postcentral')) + 162;


LN = [indices_precentral_left;indices_postcentral_left];
RN = [indices_precentral_right;indices_postcentral_right];

LN = sort(unique(LN));
LN= reshape(LN,[length(LN) 1]);
RN = sort(unique(RN));
RN= reshape(RN,[length(RN) 1]);
end

