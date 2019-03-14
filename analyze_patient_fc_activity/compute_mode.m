function [ statistic, bounds, surrogates ] = compute_mode( model, pc, nodes)
% Computes ....
%
% INPUTS:
%  model              = structure containing weighted adjacency matrix,
%                       lower and upper bounds matrix
%                       Dimensions should be [n x n x t] and the adjacency
%                       matrix should be upper triangular.
%  pc                 = structure containing xyz coordinates of the n nodes
%                       and used to compute internode distances such that 
%                       distances <=0.01 are excluded from analysis
%  nodes              = nodes indicated subnetwork of interest
%
% OUTPUTS:
%  statistic          = mode of binned coherence values
%  bounds             = vector containing lower and upper 95% confidence
%                       interval
%  surrogates         = vector of 10000 surrogates generated from 

nsurrogates= 10000;
A          = model.kC;
cube_lower = model.kLo;
cube_upper = model.kUp;

n = size(A,1);

% Replace diagonal and lower triangle NaN
M = NaN(n);
M =tril(M);

for k=1:size(A,3)
    A(:,:,k)          = A(:,:,k) + M;
    cube_lower(:,:,k) = M+cube_lower(:,:,k);
    cube_upper(:,:,k) = M+cube_upper(:,:,k);
end

% Exclude distances <=0.01
D     = compute_nodal_distances(pc.coords(3:5,:));
[i,j] = find(D<=0.01);

for k = 1:length(i)
    A(i(k),j(k),:)          = NaN;
    cube_lower(i(k),j(k),:) = NaN;
    cube_upper(i(k),j(k),:) = NaN;
end

% Define subnetworks of interest
if ~isstruct(nodes)
    A          = A(nodes,nodes,:);
    cube_lower = cube_lower(nodes,nodes,:);
    cube_upper = cube_upper(nodes,nodes,:);
else
    A          = A(nodes.source,nodes.target,:);
    cube_lower = cube_lower(nodes.source,nodes.target,:);
    cube_upper = cube_upper(nodes.source,nodes.target,:);
end


a = reshape(cube_lower,[],1);
b = reshape(cube_upper,[],1);
c = reshape(A,[],1);

a(isnan(c))=[];
b(isnan(c))=[];  %%% there are some lower bounds = 0, and upper = nan, and coh = nan ?
c(isnan(c))=[];

surrogates = nan(1,nsurrogates);

dt = 0.001;
for i = 1:nsurrogates
r = (b-a).*rand(length(a),1) + a;

[N,E]=histcounts(r,'BinEdges',0:dt:1);
[~, ix] =max(N);
surrogates(i) =(E(ix) + E(ix+1))/2; % center of bin
fprintf(['Trial: ' num2str(i) '\n'])
end

%histogram(surrogates)

[N,E]=histcounts(c,'BinEdges',0:dt:1);
[~, ix] =max(N);
statistic =(E(ix) + E(ix+1))/2; % left edges

surrogates = sort(surrogates,'ascend');
bounds     = [surrogates(0.025*nsurrogates), surrogates(0.975*nsurrogates)];


end

