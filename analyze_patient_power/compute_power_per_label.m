function [mean_data, sem_data, numElem ] = compute_power_per_label( model,patient_coordinates,band,str_list )
% COMPUTE_POWER_PER_LABEL calculates the mean and standard error of the
% mean for relative power within each brain label. Mean and standard error of the 
% mean are computed by first taking the mean across time to get an averaged 
% subnetwork corresponding to that label, and then taking the average mean 
% or standard errror of functional connectivity over all connections in that 
% label. 
%
% INPUTS:
%  model              = structure containing 'f' and 'kPower,'
% model.f             = [1 x n-freq], frequency axis. If frequency
%                       resolution is W = 0.5 and fpass = [0,50.1],
%                       frequency axis is 0:0.5:50
% model.kPower        = [n-electrodes x n-freq x n-nets], spectral power
%                       matrix
% patient coordinates = structure containing xyz coordinates of the n nodes
%                       and used to compute internode distances such that 
%                       distances <=0.01 are excluded from analysis
% band                = [1 x 2] frequency band to calculate power
%
% OUTPUTS:
% mean_data = [n-labels x 2] where entries (i,1) and (i,2) indicate the mean
%             value of power within label, 'i' on the left and right 
%             hemispheres respectively.
% sem_data  = [n-labels x 2] same as above for standard error of the mean
% numElem   = [n-labels x 2] number of connections used to compute mean_data and
%             sem_data entries.


% Initialize parameters
f         = model.f;
kPower    = nanmean(model.kPower,3); % Collapse power matrix over time
nS        = length(str_list);        % Number of strings
mean_data = zeros(nS,2);
sem_data  = zeros(nS,2);
numElem   = zeros(nS,2);
[ LNf,RNf ] = find_subnetwork_coords(patient_coordinates);

% - Compute TOTAL - power
total_power = nansum(kPower,2);
kPower      = kPower./total_power;
% Begin calculations
GN = [];
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
    indices = (f>=band(1) & f<=band(2));
    
    % Left indices --------------------------------------------------------
    temp_power = kPower(LN,indices); 
    temp_power = mean(temp_power,2); % mean power for each electrode over 
                                     % each frequency band
    
    mean_data(i,1) = mean(temp_power);           % mean over  electrodes
    sem_data(i,1)  = std(temp_power)/length(LN); % standard error of the mean
    numElem(i,1)   = length(LN);
    
    % Right indices -------------------------------------------------------
    temp_power = kPower(RN,indices); 
    temp_power = mean(temp_power,2); % mean power for each electrode over 
                                     % each frequency band
    mean_data(i,2) = mean(temp_power);
    sem_data(i,2)  = std(temp_power)/length(RN);
    numElem(i,2)   = length(RN);
    
    
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

