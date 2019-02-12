function [mean_data, sem_data, numElem,weights ] = compute_fc_per_label( model,patient_coordinates )
% COMPUTE_FC_PER_LABEL calculates the mean and standard error of the mean
% for functional connectivity within each brain label. Mean and standard
% error of the mean are computed by first taking the mean across time to
% get an averaged subnetwork corresponding to that label, and then taking
% the average mean or standard errror of functional connectivity over all
% connections in that label.  For this dataset, there are 34 labels.  The
% 34th corresponds to the seizure onset zone. Because the SOZ overlaps the
% pre and post central gyrus, we remove the overlap and the pre- and post-
% central gyrus do not include the SOZ.
%
% INPUTS:
%  model              = structure containing weighted adjacency matrix. 
%                       Dimensions should be [n x n x t] and the adjacency
%                       matrix should be upper triangular.
% patient coordinates = structure containing xyz coordinates of the n nodes
%                       and used to compute internode distances such that 
%                       distances <=0.01 are excluded from analysis
%
% OUTPUTS:
% mean_data = [34 x 2] where entries (i,1) and (i,2) indicate the mean
%             value of functional connectivity within label, 'i' on the 
%             left and right hemisphere,s respectively.
% sem_data  = [34 x 2] same as above for standard error of the mean
% numElem   = [34 x 2] number of connections used to compute mean_data and
%             sem_data entries.
% weights   = [n x 1] mean fc associated with each node

% List of all desikan labels and focus
str_list = {'insula','fusiform','parahippocampal','entorhinal', ...
    'inferiortemporal','middletemporal','superiortemporal',...
    'temporalpole','transversetemporal', ... % TEMPORAL
    'supramarginal','isthmuscingulate','posteriorcingulate', ...
    'inferiorparietal', 'superiorparietal', ...% PARIETAL
    'paracentral','precuneus','postcentral', ...
    'lingual','pericalcarine','cuneus','lateraloccipital', ... % OCCIPTIAL
    'frontalpole','parsorbitalis', 'parstriangularis' ,...
    'parsopercularis' ,'caudalanteriorcingulate', ... % FRONTAL
    'rostralanteriorcingulate','precentral', 'caudalmiddlefrontal',...
    'lateralorbitofrontal','medialorbitofrontal', 'rostralmiddlefrontal',...
    'superiorfrontal','focus'};

% Initialize parameters
nS = length(str_list);
mean_data = zeros(nS,2);
sem_data  = zeros(nS,2);
numElem   = zeros(nS,2);
[LNf,RNf] = find_subnetwork_coords(patient_coordinates);
% Begin calculations
GN = [];
weights =nan(1,size(model.kC,1));
for i =1:nS
    if strcmp(str_list{i},'focus')
        LN = LNf;
        RN = RNf;
        GN = [GN; LN; RN];
    else

        [LN, RN] = find_subnetwork_str(patient_coordinates,str_list{i});  
        % Removes overlap between pre and post central gyruss
        if strcmp(str_list{i},'precentral') || strcmp(str_list{i},'postcentral')
            LN = setdiff(LN,LNf);
            RN = setdiff(RN,RNf);
        end
        GN = [GN; LN; RN];
    end
    
    % Note that function patient_activity excludes distances <0.01
    [~, mL, ~,semL] = compute_patient_activity(model,patient_coordinates,LN);
    [~, mR, ~,semR] = compute_patient_activity(model,patient_coordinates,RN);
    
    mean_data(i,1) = mL;
    mean_data(i,2) = mR;
    sem_data(i,1)  = semL;
    sem_data(i,2)  = semR;
    numElem(i,1)   = length(LN);
    numElem(i,2)   = length(RN);

    weights(LN) = mL;
    weights(RN) = mR;
    
end

ii=1:324;
ii(GN)=[];
labels =[ patient_coordinates.LDL; patient_coordinates.RDL];
left_out_labels = labels(ii);
left_out_labels(strcmp(left_out_labels,'bankssts')) =[];

% If there are labels not included in analysis that are not empty, '[]' or
% 'bankssts', print statement.
if sum(cellfun(@isempty,left_out_labels)) ~= length(left_out_labels)
    fprintf(['These nodes were not included in the analysis: \n'])
    left_out_labels
end



end

