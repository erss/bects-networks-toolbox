
strlist = {'pBECTS003','pBECTS006','pBECTS007','pBECTS013','pBECTS019','pBECTS020'};
nS = length(strlist);
X  = NaN(nS,2);
y  = NaN(nS,1);

%%% Directory where models are
DATAPATH = '~/Desktop/pBECTS_results/coherence - r4/';
mfi = dir(DATAPATH);
pList = struct2cell(mfi);
pList = pList(1,:);

for i = 1:nS
    patient = strlist{i};
    
    % Find patient in master spread sheert for task performance (outcome variable)
    iDATA = find(masterspread.ID==patient);
    y(i)  = masterspread.GPBdomRaw(iDATA);
    
    % Find and load patient's model structure
    iModel = find(contains(pList,patient));
    if length(iModel) > 1
        iModel = iModel(end);
    end
    load([DATAPATH mfi(iModel).name])
    model = model_sigma_two;
    
    % Find and load patient's patient coordinates structure
    %%% Direcotry where patient coordinates are
    DATAPATH2 = ['~/Desktop/' patient '/'];
    pc = load_patient_coordinates( DATAPATH2, patient);
    pc.hand = char(masterspread.Handedness(iDATA));
    % Build network features
    [ nodes.source,nodes.target] = find_subnetwork_prepost(pc);
    [~,fc] = compute_patient_activity( model,pc,nodes);
    X(i,1) = fc;
    if masterspread.Group(iDATA) == 'Active'
        X(i,2) = 1;
    elseif masterspread.Group(iDATA) == 'Healthy'
        X(i,2) = 0;
    end
    % 
    
end

%% Fit just FC
mdl = fitglm(X(:,1),y);
m= mdl.Coefficients.Estimate(2);
b= mdl.Coefficients.Estimate(1);


xaxis = min(X(:,1)):0.001:max(X(:,1));
figure; hold on;
plot(X(:,1),y,'o')
plot(xaxis,m*xaxis+b,'k','LineWidth',2)