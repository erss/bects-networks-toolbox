function average_strengths = compute_average_strength( model,patient_coordinates,specs )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
% Obtain weighted network

if strcmp(specs.A,'raw' )
    A=model.mx0;
    
    for k=1:size(A,3)
        Atemp = A(:,:,k);
        Atemp = Atemp + transpose(Atemp);
        A(:,:,k) = Atemp;
    end
    
elseif strcmp(specs.A,'binary' )
    A=model.C;
else
    A= NaN;
end

A = nanmean(A,3);

% Replace diagonals with NaNs to ignore self connections
n = size(A,1);
A(1:1+n:end) = NaN;

% Determine subnetwork indices
[LN,RN] = find_subnetwork_coords( patient_coordinates);
%[ LN,RN ] = find_subnetwork_central( patient_coordinates)
TN  = find_subnetwork_lobe( patient_coordinates,'temporal');
GN = setdiff(1:n,[LN,RN]);
[ PreN,PostN ] = find_subnetwork_prepost( patient_coordinates);
% Define subnetworks of interest
if strcmp(patient_coordinates.status,'active-left')
    network_focus_to_focus= A(LN,LN,:);
elseif strcmp(patient_coordinates.status,'active-right')
    network_focus_to_focus= A(RN,RN,:);
elseif strcmp(patient_coordinates.status, 'healthy')
    Aleft = A(LN,LN,:);
    Aright = A(RN,RN,:);
    diagNaN1 = NaN(size(A(LN,RN,:)));
    diagNaN2 = NaN(size(A(RN,LN,:)));
    network_focus_to_focus = [Aleft diagNaN1; diagNaN2 Aright];
end

network_left_to_right = A(LN,RN);          % left focus to right focus
network_focus_to_global = A([LN RN],GN);   % focus to rest of network ex-
                                             % cluding focus
network_focus_to_temporal = A([LN RN],TN);   % focus to rest of temporal
                                             % lobe excluding focus
network_pre_to_post = A(PreN,PostN);   % pre to post central in dom-
                                             % inant hemisphere
network_temp_to_temp = A(TN,TN);                                             
% Compute average strengths relative to global strengths

average_strengths.kGlobal = nanmean(A(:));

if strcmp(specs.normalize,'true' )
    average_strengths.kFF = nanmean(network_focus_to_focus(:))/nanmean(A(:));
    average_strengths.kFG = nanmean(network_focus_to_global(:))/nanmean(A(:));
    average_strengths.kLR = nanmean(network_left_to_right(:))/nanmean(A(:));
    average_strengths.kFT = nanmean(network_focus_to_temporal(:))/nanmean(A(:));
    average_strengths.kPrPo = nanmean(network_pre_to_post(:))/nanmean(A(:));
    average_strengths.kTT = nanmean(network_temp_to_temp(:))/nanmean(A(:));
    
elseif strcmp(specs.normalize,'false' )
    average_strengths.kFF = nanmean(network_focus_to_focus(:));
    average_strengths.kFG = nanmean(network_focus_to_global(:));
    average_strengths.kLR = nanmean(network_left_to_right(:));
    average_strengths.kFT = nanmean(network_focus_to_temporal(:));
    average_strengths.kPrPo = nanmean(network_pre_to_post(:));
    average_strengths.kTT = nanmean(network_temp_to_temp(:));
else
    average_strengths= NaN;
end

end

