function [ LN,RN ] = find_subnetwork_lobe( patient_coordinates,str)
% rChoose subnetworks based on name
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
LN  = find(contains(LDL,str));
RN  = find(contains(RDL,str)) + 162;


LN = sort(LN);
RN = sort(RN);

end

