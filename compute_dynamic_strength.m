function dynamic_strengths =compute_dynamic_strength(model,patient_coordinates,specs)
%UNTITLED8 Summary of this function goes here
%   Detailed explanation goes here


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
 
% Replace diagonals with NaNs to ignore self connections
n = size(A,2);
for k=1:size(A,3)
    Atemp = A(:,:,k);
    Atemp(1:1+n:end) = NaN;
    A(:,:,k)=Atemp;
end

% Determine LN, RN (focus indices) & GN (indices excluding LN RN)
[LN,RN] = find_subnetwork_coords( patient_coordinates);
%[LN,RN] = find_subnetwork_central( patient_coordinates);

GN = setdiff(1:n,[LN,RN]);

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

network_left_to_right = A(LN,RN,:);          % left focus to right focus
network_focus_to_global = A([LN RN],GN,:);   % focus to rest of network ex-
                                             % cluding focus
                                             
% Initialize corresponding functional connectivitiy vectors                                            
fc_global = zeros(1,size(A,3));
fc_focus_to_focus   = zeros(1,size(A,3));
fc_left_to_right = zeros(1,size(A,3));
fc_focus_to_global = zeros(1,size(A,3));

for i = 1:size(A,3)
    
    % Grab each network at each point in time
    nG   = A(:,:,i);
    nF   = network_focus_to_focus(:,:,i);    
    nA   = network_left_to_right(:,:,i);
    nFG = network_focus_to_global(:,:,i);
    
    % Compute and store density at that instant
    fc_global(i) = nanmean(nG(:));
    fc_focus_to_focus(i)= nanmean(nF(:));
    fc_left_to_right(i) = nanmean(nA(:));
    fc_focus_to_global(i) = nanmean(nFG(:));
end

% Store global densities over time
dynamic_strengths.global = fc_global;

% Store relative densities (densitiy of subnetwork normalized by global de-
% nsity) over time.

if strcmp(specs.normalize,'true' )
    dynamic_strengths.focus           = fc_focus_to_focus./fc_global;
    dynamic_strengths.across          = fc_left_to_right./fc_global;
    dynamic_strengths.focus_to_global = fc_focus_to_global./fc_global;
elseif strcmp(specs.normalize,'false' )
    dynamic_strengths.focus           = fc_focus_to_focus;
    dynamic_strengths.across          = fc_left_to_right;
    dynamic_strengths.focus_to_global = fc_focus_to_global;
else
    dynamic_strengths= NaN;
end



end

