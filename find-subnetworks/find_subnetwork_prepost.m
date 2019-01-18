function [ PreN,PostN ] = find_subnetwork_prepost( patient_coordinates)
% Returns indices of the pre- and post- central gyrus (PreN and PostN,
% respectively) contralateral to the dominant hand.
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

hand = patient_coordinates.hand;
if strcmp(hand,'right')
    PreN   = find(strcmp(LDL,'precentral'));
    PostN  = find(strcmp(LDL,'postcentral'));
end

if strcmp(hand,'left')
    PreN  = find(strcmp(RDL,'precentral')) + 162;
    PostN= find(strcmp(RDL,'postcentral')) + 162;
end


PreN = sort(unique(PreN));
PreN= reshape(PreN,[length(PreN) 1]);
PostN = sort(unique(PostN));
PostN= reshape(PostN,[length(PostN) 1]);
end

