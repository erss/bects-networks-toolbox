function [ LN,RN ] = find_subnetwork_str( patient_coordinates,str)
% Returns indices of all nodes with label, 'str'. Outputs LN and RN
% correspond to nodes on the left and right hemispheres respectively. 

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

LN = find(strcmp(LDL,str));
RN = find(strcmp(RDL,str));

LN = sort(unique(LN));
LN= reshape(LN,[length(LN) 1]);

RN = sort(unique(RN))+162;
RN= reshape(RN,[length(RN) 1]);


end

