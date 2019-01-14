
%% imaginary coherence for subject 13
load('/Users/erss/Documents/MATLAB/pBECTS_inferred_nets/coherence - r1/pBECTS013_rest02_coherence.mat')

distr = model.distr_imag_coh;
A     = model.kIC_beta;
Anet  = model.net_imag_coh;

% Replace diagnoals with NaNs to ignore self connections
M = NaN(size(A,2));
M =tril(M);
for k=1:size(A,3)
    Atemp = A(:,:,k);
    A(:,:,k)=Atemp + M;
    
    Atemp = Anet(:,:,k);
    Anet(:,:,k)=Atemp + M;
end

Anet_collapse = nansum(Anet,3);
Anet_collapse = M +Anet_collapse;
imagesc(Anet_collapse);
%%
[i,j] = find(Anet_collapse==2);
Aij   = real(squeeze(A(i(1),j(1),:)));  % make sure i < j
figure;
histogram(Aij)
xlabel('imaginary coherence')
title('histogram of IC values for node pair #1 over time')

Aij   = real(squeeze(A(i(2),j(2),:)));
figure;
histogram(Aij)
xlabel('imaginary coherence')
title('histogram of IC values for node pair #2 over time')
figure;
histogram(distr)
xlabel('imaginary coherence')
title('surrogate distr')


%% phase for patient 20
load('/Users/erss/Documents/MATLAB/pBECTS_inferred_nets/coherence - r3/new_patient20_wo_bad_channel/pBECTS020_rest05__phase.mat')
load('/Users/erss/Documents/MATLAB/pBECTS020/patient_coordinates_020.mat')
pc = patient_coordinates_020;
A     = model.phi;
Anet  = model.net_coh;
% Replace diagonals + lower diag with NaNs to ignore self connections
M = NaN(size(A,2));
M =tril(M);
for k=1:size(A,3)
    Atemp = A(:,:,k);
    A(:,:,k)=Atemp + M;
    
    Atemp = Anet(:,:,k);
    Anet(:,:,k)=Atemp + M;
end

Anet_collapse = nansum(Anet,3);
Anet_collapse = M + Anet_collapse;
figure;
subplot 131
imagesc(Anet_collapse);
axis square
colorbar
title('Number of Connections over Time')

subplot 132
phi_collapse = nanmean(A,3);
phi_collapse = M + phi_collapse;
imagesc(phi_collapse)
colorbar
axis square
title('Mean phase')
subplot 133
D = compute_nodal_distances(pc.coords(3:5,:));
imagesc(D)
colorbar
title('Distances')
axis square

figure;
subplot 211
D1 = round(D(:),3);
D1(isnan(D1)) =[];
P1 = phi_collapse(:);
P1(isnan(P1)) =[];
data = [D1 P1];
data1= sortrows(data);
plot(data1(:,1),data1(:,2))
xlabel('distance')
ylabel('mean phase')

subplot 212
histogram(P1)
xlabel('mean phase')
ylabel('counts')

%%% phase pair far apart and connected
[i1,j1] = find(round(D,2)>=0.12);
[i2,j2] = find(Anet_collapse>=100);
p1= table([i1 j1]);
p2= table([i2 j2]);
T=intersect(p1,p2)

for k = 1:20
  p=  T.Var1(k,:);
figure;
histogram(A(p(1),p(2),:))
xlabel('phase')
ylabel('counts')
title('Far apart & mostly connected')
xlim([-2*pi 2*pi])
end


%%% phase pair far apart and NOT connected
[i1,j1] = find(round(D,2)==0.12);
[i2,j2] = find(Anet_collapse<=10);
p1= table([i1 j1]);
p2= table([i2 j2]);
T=intersect(p1,p2)

for k = 1:20
  p=  T.Var1(k,:);
figure;
histogram(A(p(1),p(2),:))
xlabel('phase')
ylabel('counts')
title('Phase pair far apart & sometimes connected')
xlim([-2*pi 2*pi])
end

%%% phase pair close and connected
[i1,j1] = find(round(D,2)==0.02);
[i2,j2] = find(Anet_collapse>=100);
p1= table([i1 j1]);
p2= table([i2 j2]);
T=intersect(p1,p2)

for k = 1:20
  p=  T.Var1(k,:);
figure;
histogram(A(p(1),p(2),:))
xlabel('phase')
ylabel('counts')
title('Phase pair close & mostly connected')
xlim([-2*pi 2*pi])
end

%%% phase pair close and NOT connected
[i1,j1] = find(round(D,2)==0.02);
[i2,j2] = find(Anet_collapse<=10);
p1= table([i1 j1]);
p2= table([i2 j2]);
T=intersect(p1,p2)

for k = 1:20
  p=  T.Var1(k,:);
figure;
histogram(A(p(1),p(2),:))
xlabel('phase')
ylabel('counts')
title('Phase pair close & sometimes connected')
xlim([-2*pi 2*pi])
end
