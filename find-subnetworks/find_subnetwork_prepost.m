function [ PreN,PostN,PreUpperN,PostUpperN ] = find_subnetwork_prepost( patient_coordinates)
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
[LN,RN] = find_subnetwork_coords(patient_coordinates);

hand = patient_coordinates.hand;
if strcmp(hand,'right')
    PreN   = find(strcmp(LDL,'precentral'));
    PostN  = find(strcmp(LDL,'postcentral'));
    PreUpperN = setdiff(PreN,LN);
    PostUpperN = setdiff(PostN,LN);
end

if strcmp(hand,'left')
    PreN  = find(strcmp(RDL,'precentral')) + 162;
    PostN= find(strcmp(RDL,'postcentral')) + 162;
    PreUpperN = setdiff(PreN,RN);
    PostUpperN = setdiff(PostN,RN);
end


PreN = sort(unique(PreN));
PreN= reshape(PreN,[length(PreN) 1]);
PostN = sort(unique(PostN));
PostN= reshape(PostN,[length(PostN) 1]);

PreUpperN = sort(unique(PreUpperN));
PreUpperN= reshape(PreUpperN,[length(PreUpperN) 1]);
PostUpperN = sort(unique(PostUpperN));
PostUpperN= reshape(PostUpperN,[length(PostUpperN) 1]);
end

