
addpath(genpath('fc-network-inference-bootstrap'))
addpath(genpath('BECTS-networks'))
load('/Users/erss/Documents/MATLAB/pBECTS_inferred_nets/coherence - r3/new_patient20_wo_bad_channel/pBECTS020_rest05__coherence_v3.mat')
model020_05 = model;
clear model
load('/Users/erss/Documents/MATLAB/pBECTS_inferred_nets/coherence - r3/new_patient20_wo_bad_channel/pBECTS020_rest06__coherence_v3.mat')
model020_06=model;
clear model
A = cat(3,model020_05.kC,model020_06.kC);
%%
name=model.patient_name;
pc=patient_coordinates_020;
xyz=pc.coords(3:5,:);
D = compute_nodal_distances( xyz );
[ LN,RN ] = find_subnetwork_coords( pc);
A = bsxfun(@plus,A,tril(nan(324)));
DSOZ = D([LN; RN],[LN;RN]);
ASOZ = A([LN; RN],[LN;RN],:);
ASOZ(1:length(LN),length(LN)+1:end,:)=NaN;
DSOZ(1:length(LN),length(LN)+1:end)=NaN;

t= size(ASOZ,3);
%% Find indices whose distances are <= 0.01 & remove from analysis
i = find(DSOZ<=0.01);
for ii = 1:t
    Atemp =ASOZ(:,:,ii);
    Atemp(i)=NaN;
    ASOZ(:,:,ii)=Atemp;
end
%%% only use means
y = nanmean(ASOZ,3);
y=y(:);
y(isnan(y))=[];
X=DSOZ(:);
X(isnan(X))=[];
X(X<=0.01)=[];

M = [X, y];
M = sortrows(M);
mdl = fitglm(M(:,1),M(:,2),'Distribution','normal','link','identity');
beta = mdl.Coefficients.Estimate
mdl.Coefficients.pValue
figure;
plot(X,beta(2).*X+beta(1),'g')
hold on;
plot(M(:,1),M(:,2),'*')
xlabel('distance')
ylabel('mean coherence')
%% Use every data point
Atemp=ASOZ;
Atemp2=ASOZ;
for ii = t:-1:1
    Avect = reshape(ASOZ(:,:,ii),[],1);
    if all(isnan(Avect))
        Atemp(:,:,ii)=[];
    end
end

D1 = DSOZ(DSOZ>0.01);
yall = reshape(ASOZ,[],1);
Xall = repmat(D1(:),size(Atemp,3),1);

yall(isnan(yall))=[];
Xall(isnan(Xall))=[];

M = [Xall, yall];
M = sortrows(M);
mdl2 = fitglm(M(:,1),M(:,2),'Distribution','normal','link','identity');
betaAll = mdl2.Coefficients.Estimate
figure;
mdl2.Coefficients.pValue

plot(M(:,1),M(:,2),'*')
hold on
plot(X,betaAll(2).*X+betaAll(1),'g')
