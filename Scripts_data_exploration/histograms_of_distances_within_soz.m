%%% What are the distribution of distances between nodes - i.e. do we need
%%% to correct? 1. global 2. between 3. LN 4.  RN
addpath(genpath('fc-network-inference-bootstrap'))
addpath(genpath('BECTS-networks'))

name=model.patient_name;
pc=patient_coordinates_006;
xyz=pc.coords(3:5,:);
D = compute_nodal_distances( xyz );
[ LN,RN ] = find_subnetwork_coords( pc);
DB = D(LN,RN);
DL=D(LN,LN);
DR=D(RN,RN);
A =model.kC;
n=324;
A = bsxfun(@plus,A,tril(nan(n)));
AL = nanmean(A(LN,LN,:),3);
AR = nanmean(A(RN,RN,:),3);
AB = nanmean(A(LN,RN,:),3);

figure;

ax1=subplot(131);
histogram(DB(:))
axis square
title('between')

ax2=subplot(132);
histogram(DL(:))
axis square
title('left')

ax3=subplot(133);
histogram(DR(:))
title('right')
axis square
linkaxes([ax2,ax3],'xy')
suptitle(num2str(name))
%%
AL = A(LN,LN,:);
AR = A(RN,RN,:);
AB = A(LN,RN,:);
t = size(A,3);
figure;
subplot 131
plot(repmat(DL(:),t,1),AL(:),'.')
xlabel('distance');
ylabel('coherence');
title('left')
axis square
subplot 132
plot(repmat(DR(:),t,1),AR(:),'.')
xlabel('distance');
ylabel('coherence');
title('right')
axis square
subplot 133
plot(repmat(DB(:),t,1),AB(:),'.')
xlabel('distance');
ylabel('coherence');
title('between')
axis square

AL = nanmean(model.kC(LN,LN,:),3);
AR = nanmean(model.kC(RN,RN,:),3);
AB = nanmean(model.kC(LN,RN,:),3);
subplot 131
hold on
plot(DL(:),AL(:),'r*')
xlabel('distance');
ylabel('coherence');
title('left')
axis square
subplot 132
hold on
plot(DR(:),AR(:),'r*')
xlabel('distance');
ylabel('coherence');
title('right')
axis square
subplot 133
hold on
plot(DB(:),AB(:),'r*')
xlabel('distance');
ylabel('coherence');
title('between')
axis square
suptitle(num2str(name))
%DR(find(DR>0.0242))=NaN;

%% Find indices whose distances are <= 0.01 & remove from analysis
i = find(D<=0.01);
for ii = 1:t
    Atemp =A(:,:,ii);
    Atemp(i)=NaN;
    A(:,:,ii)=Atemp;
end
%%% only use means
y = nanmean(A,3);
y=y(:);
y(isnan(y))=[];
X=D(:);
X(isnan(X))=[];
X(X<=0.01)=[];

M = [X, y];
M = sortrows(M);
[b,dev,stats] = glmfit(X,y,'normal','link','identity');
plot(X,b(2).*X+b(1),'g')
b
stats.p

figure; hold on;
plot(X,y,'.')
plot(X,b(2).*X+b(1),'g')
xlabel('distance');
ylabel('coherence');
