function [density,mn_network,std_network,sem_network] = compute_patient_activity( model,pc,nodes)
% Computes density traces of weighted network values for given
% subnetwork.
%
% INPUTS:
%  model              = structure containing weighted adjacency matrix. 
%                       Dimensions should be [n x n x t] and the adjacency
%                       matrix should be upper triangular.
% patient coordinates = structure containing xyz coordinates of the n nodes
%                       and used to compute internode distances such that 
%                       distances <=0.01 are excluded from analysis
%  nodes              = nodes indicated subnetwork of interest
%
% OUTPUTS:
%  density     = [1 x t] vector containing mean network density at each time point
%  mn_network  = [1] mean of the averaged subnetwork (ie. 1. Mean over time
%                    2. mean over electrodes in region)
%  std_network = [1] std of the averaged subnetwork 
%  sem_network = [1] sem of the averaged subnetwork 

A= model.kC;
n = size(A,1);

% Replace diagonal and lower triangle NaN
M = NaN(size(A,2));
M =tril(M);
for k=1:size(A,3)
    Atemp = A(:,:,k);
    A(:,:,k)=Atemp + M;
end

% Exclude distances <=0.01
D = compute_nodal_distances(pc.coords(3:5,:));
[i,j]=find(D<=0.01);
for k = 1:length(i)
    A(i(k),j(k),:) = NaN;
end

taxis = model.dynamic_network_taxis;

% Define subnetworks of interest
if ~isstruct(nodes)
    network = A(nodes,nodes,:);
else
    network = A(nodes.source,nodes.target,:);
end
fc      = zeros(1,size(A,3));

for i = 1:size(A,3)
    
    % Grab each network at each point in time
    n1  = network(:,:,i);    % grab each network at each point in time

    % Compute and store density at that index
    fc(i)    = nanmean(n1(:)); % compute and store mean connectivity for
                            % ... each network
end
density = fc;

n2 = nanmean(network,3);
n2 = n2(:);
mn_network = nanmean(n2);
std_network = nanstd(n2);
sem_network = nanstd(n2)/sqrt(length(n2(~isnan(n2))));

end

