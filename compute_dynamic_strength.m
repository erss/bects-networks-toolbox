function dynamic_strengths =compute_dynamic_strength(model,patient_coordinates,specs)
%UNTITLED8 Summary of this function goes here
%   Detailed explanation goes here


if strcmp(specs.A,'raw' )
    if strcmp(specs.measure,'coherence' )
        A = model.kC;
    elseif strcmp(specs.measure,'xcorr' )
        A = model.mx0;
    else
        A = NaN;
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

% Replace diagonals with NaNs to ignore self connections
n = size(A,2);
for k=1:size(A,3)
    Atemp = A(:,:,k);
    Atemp(1:1+n:end) = NaN;
    A(:,:,k)=Atemp;
end

% Determine LN, RN (focus indices) & GN (indices excluding LN RN)
[LN,RN] = find_subnetwork_coords( patient_coordinates);

GN = setdiff(1:n,[LN;RN]);
GNl = setdiff(1:162,LN);
GNr = setdiff(163:324,RN);
% Define subnetworks of interest

if strcmp(patient_coordinates.status,'active-left')
    Al= A(LN,LN,:);
    Ar=nan(size(Al));
    Alg = A(LN,GNl,:);   % focus to rest of network ex-
    % cluding focus
    Arg = Ar;
elseif strcmp(patient_coordinates.status,'active-right')
    Ar= A(RN,RN,:);
    Al=nan(size(Ar));
    Arg = A(RN,GNr,:);   % focus to rest of network ex-
    % cluding focus
    Alg =Al;
elseif strcmp(patient_coordinates.status, 'healthy')
    Al = A(LN,LN,:);
    Ar = A(RN,RN,:);
    
    Alg = A(LN,GNl,:);
    Arg = A(RN,GNr,:);
end
[PreN, PostN] = find_subnetwork_prepost( patient_coordinates);
network_pre_to_post = A(PreN,PostN,:);   % pre to post central in dom-
                                       % inant hemisphere
network_left_to_right = A(LN,RN,:);          % left focus to right focus
%network_focus_to_global = A([LN RN],GN,:);   % focus to rest of network ex-
% cluding focus

% Initialize corresponding functional connectivitiy vectors
fc_global          = zeros(1,size(A,3));
fc_focus_to_focus  = zeros(1,size(A,3));
fc_left_to_right   = zeros(1,size(A,3));
fc_focus_to_global = zeros(1,size(A,3));
fc_pre_to_post   = zeros(1,size(A,3));
for i = 1:size(A,3)
    
    % Grab each network at each point in time
    nG   = A(:,:,i);
    nFl   = Al(:,:,i);
    nFr   = Ar(:,:,i);
    nA   = network_left_to_right(:,:,i);
    nFGl  = Alg(:,:,i);
    nFGr = Arg(:,:,i);
    nPrPo = network_pre_to_post(:,:,i);
    % Compute and store density at that instant
    fc_global(i)          = nanmean(nG(:));
    fc_focus_to_focus(i)  = nanmean([nanmean(nFl(:)) nanmean(nFr(:))]);
    fc_left_to_right(i)   = nanmean(nA(:));
    fc_focus_to_global(i) = nanmean([nanmean(nFGl(:)) nanmean(nFGr(:))]);
    fc_pre_to_post(i)        = nanmean(nPrPo(:));
end

% Store global densities over time
dynamic_strengths.global = fc_global;

% Store relative densities (densitiy of subnetwork normalized by global de-
% nsity) over time.

if strcmp(specs.normalize,'true' )
    dynamic_strengths.focus           = fc_focus_to_focus./fc_global;
    dynamic_strengths.across          = fc_left_to_right./fc_global;
    dynamic_strengths.focus_to_global = fc_focus_to_global./fc_global;
    dynamic_strengths.pre_post        = fc_pre_to_post./fc_global;
elseif strcmp(specs.normalize,'false' )
    dynamic_strengths.focus           = fc_focus_to_focus;
    dynamic_strengths.across          = fc_left_to_right;
    dynamic_strengths.focus_to_global = fc_focus_to_global;
    dynamic_strengths.pre_post        = fc_pre_to_post;
else
    dynamic_strengths= NaN;
end

end

