function average_strengths = compute_average_strength( model,patient_coordinates,specs )
% COMPUTE_AVERAGE_STRENGTH computes first the average (weighted or unweighted)
% network.  Then computes mean value within following subnetworks.
%
%%% INPUTS:
%  specs = structure containing two specifications:
%          - specs.A: 'raw' uses raw functional connectivity values, or
%            'binary' uses inferred binary network
%          - specs.measure: 'coherence' or 'xcorr', indicates functional
%            connectivity measure
%          - specs.normalize: 'true' or 'false', indicates if values are
%            normalized by the mean global average
%
%
%%% OUTPUTS:
%  average_strengths = structure that returns ...
if strcmp(specs.A,'raw' )
    if strcmp(specs.measure,'coherence' )
        A= model.kC;
        fprintf('coh')
    elseif strcmp(specs.measure,'xcorr' )
        A=model.mx0;
    else
        A=NaN;
    end
    
    for k=1:size(A,3)
        Atemp = A(:,:,k);
        Atemp = Atemp + transpose(Atemp);
        A(:,:,k) = Atemp;
    end
    
elseif strcmp(specs.A,'binary' )
    if strcmp(specs.measure,'coherence' )
        A = model.net_coh;
    elseif strcmp(specs.measure,'xcorr' )
        A = model.C;
    else
        A=NaN;
    end
else
    A= NaN;
end

A = nanmean(A,3);

% Replace diagonals with NaNs txo ignore self connections
n = size(A,1);
A(1:1+n:end) = NaN;

% Determine subnetwork indices
[LN, RN] = find_subnetwork_coords( patient_coordinates);
GNl = setdiff(1:162,LN);
GNr = setdiff(163:324,RN);
[PreN, PostN] = find_subnetwork_prepost( patient_coordinates);

% Define subnetworks of interest
if strcmp(patient_coordinates.status,'active-left')
    network_focus_to_focus  = A(LN,LN);
    network_focus_to_global = A(LN,[GNl 163:324]); % focus to rest of network in ips-
                                         % ilateral hemisphere excluding 
                                         % left SOZ
elseif strcmp(patient_coordinates.status,'active-right')
    network_focus_to_focus  = A(RN,RN);
    network_focus_to_global = A(RN,[1:162 GNr]); % focus to rest of network in ips-
                                         % ilateral hemisphere excluding 
                                         % right SOZ
elseif strcmp(patient_coordinates.status, 'healthy')
    Al = A(LN,LN);
    Ar = A(RN,RN);
    network_focus_to_focus = [nanmean(Al(:)) nanmean(Ar(:))];
    
    Al = A(LN,GNl);
    Ar = A(RN,GNr);
    network_focus_to_global = [nanmean(Al(:)) nanmean(Ar(:))];  % focus to rest of network ex-
    % cluding focus
    
end

network_left_to_right = A(LN,RN);      % left SOZ to right SOZ
network_pre_to_post = A(PreN,PostN);   % pre to post central in dom-
% inant hemisphere

% Compute average strengths relative to global strengths

average_strengths.kGlobal = nanmean(A(:));

if strcmp(specs.normalize,'true' )
    average_strengths.kFF = nanmean(network_focus_to_focus(:))/nanmean(A(:));
    average_strengths.kFG = nanmean(network_focus_to_global(:))/nanmean(A(:));
    average_strengths.kLR = nanmean(network_left_to_right(:))/nanmean(A(:));
    average_strengths.kPrPo = nanmean(network_pre_to_post(:))/nanmean(A(:));
elseif strcmp(specs.normalize,'false' )
    average_strengths.kFF = nanmean(network_focus_to_focus(:));
    average_strengths.kFG = nanmean(network_focus_to_global(:));
    average_strengths.kLR = nanmean(network_left_to_right(:));
    average_strengths.kPrPo = nanmean(network_pre_to_post(:));
else
    average_strengths= NaN;
end

end

