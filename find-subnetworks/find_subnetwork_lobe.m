function [ LN,RN ] = find_subnetwork_lobe( patient_coordinates,str)
% Choose subnetworks based on name
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
LN =[];
RN =[];

LN  = find(contains(LDL,str));
RN  = find(contains(RDL,str));

if strcmp(str,'temporal')
    
    LN =[LN; find(strcmp(LDL,'insula'))];
    LN =[LN; find(strcmp(LDL,'fusiform'))];
    LN =[LN; find(strcmp(LDL,'parahippocampal'))];
    LN =[LN; find(strcmp(LDL,'entorhinal'))]; 
    
    RN =[RN; find(strcmp(RDL,'insula'))];
    RN =[RN; find(strcmp(RDL,'fusiform'))];
    RN =[RN; find(strcmp(RDL,'parahippocampal'))];
    RN =[RN; find(strcmp(RDL,'entorhinal'))]; 
    
elseif  strcmp(str,'parietal')
    
    LN =[LN; find(strcmp(LDL,'supramarginal'))];
    LN =[LN; find(strcmp(LDL,'isthmuscingulate'))];
    LN =[LN; find(strcmp(LDL,'posteriorcingulate'))];
    LN =[LN; find(strcmp(LDL,'paracentral'))];
    LN =[LN; find(strcmp(LDL,'precuneus'))];
    LN =[LN; find(strcmp(LDL,'postcentral'))];
     
    RN =[RN; find(strcmp(RDL,'supramarginal'))];
    RN =[RN; find(strcmp(RDL,'isthmuscingulate'))];
    RN =[RN; find(strcmp(RDL,'posteriorcingulate'))];
    RN =[RN; find(strcmp(RDL,'paracentral'))];
    RN =[RN; find(strcmp(RDL,'precuneus'))];
    RN =[RN; find(strcmp(RDL,'postcentral'))];
elseif  strcmp(str,'occipital')
    
    LN =[LN; find(strcmp(LDL,'lingual'))];
    LN =[LN; find(strcmp(LDL,'pericalcarine'))];
    LN =[LN; find(strcmp(LDL,'cuneus'))];
    
    RN =[RN; find(strcmp(RDL,'lingual'))];
    RN =[RN; find(strcmp(RDL,'pericalcarine'))];
    RN =[RN; find(strcmp(RDL,'cuneus'))];
    
elseif  strcmp(str,'frontal')
    LN =[LN; find(contains(LDL,'parsorbitalis'))]; % ?
    LN =[LN; find(contains(LDL,'parstriangularis'))]; % ?
    LN =[LN; find(contains(LDL,'parsopercularis'))]; % ?
    LN =[LN; find(strcmp(LDL,'caudalanteriorcingulate'))];
    LN =[LN; find(strcmp(LDL,'rostralanteriorcingulate'))];
    LN =[LN; find(strcmp(LDL,'precentral'))];
  
    RN =[RN; find(contains(RDL,'parsorbitalis'))]; % ?
    RN =[RN; find(contains(RDL,'parstriangularis'))]; % ?
    RN =[RN; find(contains(RDL,'parsopercularis'))]; % ?
    RN =[RN; find(strcmp(RDL,'caudalanteriorcingulate'))];
    RN =[RN; find(strcmp(RDL,'rostralanteriorcingulate'))];
    RN =[RN; find(strcmp(RDL,'precentral'))];
    
else
    
end

%%%
% bankssts??
% parsopercularis ?= opercularis
% 'parstriangularis' ?=  'triangularis'
% 'parsorbitalis'
%%%

LN = sort(unique(LN));
LN= reshape(LN,[length(LN) 1]);
RN = sort(unique(RN))+162;
RN= reshape(RN,[length(RN) 1]);

end

