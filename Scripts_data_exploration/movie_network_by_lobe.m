% NOTE: We are analyzing BETA, but possible bands for interest could be:
% delta (1-4 Hz), theta (4-8 Hz), alpha (8-12 Hz), beta (12-30 Hz),
% gamma (30-50 Hz)

% Load filter
addpath(genpath(['Dynanets/2-preprocess']))
addpath(genpath(['Toolboxes/mgh']))

pc=patient_coordinates_020;

% Find all relevant subnetworks
[LNp,RNp] = find_subnetwork_lobe( pc,'parietal');
[LNt,RNt] = find_subnetwork_lobe( pc,'temporal');
[LNo,RNo] = find_subnetwork_lobe( pc,'occipital');
[LNf,RNf] = find_subnetwork_lobe( pc,'frontal');
[LN,RN]   = find_subnetwork_central( pc);
left_net = [LNp;LNt;LNo;LNf];
right_net = [RNp;RNt;RNo;RNf];
ii = 1:324;
ii([left_net;right_net])=[];
specs.A = 'raw'; % raw or binary
specs.measure ='coherence';
[r,d]= compute_patient_activity(model,pc);
%% Visualize filtered data

OUTVIDPATH1 = strcat('~/Desktop/',model.patient_name,'_networks.avi');
v = VideoWriter(OUTVIDPATH1);
v.FrameRate=1;
open(v);

h=figure;

for k = 1:size(model.net_coh,3)
    
    figure(h)
    
    h1 = subplot(2,3,1);
    plotNetwork(model.net_coh([LNt;RNt],[LNt;RNt],k),h1);
    title('Temporal')
    
    h2 = subplot(2,3,2);
    plotNetwork(model.net_coh([LNp;RNp],[LNp;RNp],k),h2);
    title('Parietal')
    
    
    subplot(2,3,3)
    plot(d.left,'r')
    hold on
    plot(k,d.left(k),'*r')
    plot(d.right,'g')
    plot(k,d.right(k),'*g')
    plot(d.global,'k')
    plot(k,d.global(k),'*k')
    axis tight
    h4 = subplot(2,3,4);
    plotNetwork(model.net_coh([LNo;RNo],[LNo;RNo],k),h4);
    title('Occipital')
    
    h5 = subplot(2,3,5);
    plotNetwork(model.net_coh([LNf;RNf],[LNf;RNf],k),h5);
    title('Frontal')
    
    h6=subplot(2,3,6);
    plotNetwork(model.net_coh([LN;RN],[LN;RN],k),h6)
    title('Focus')
    drawnow
    
    suptitle(['Index: ' num2str(k)])
    
    F = getframe(h);
    image = F.cdata;
    writeVideo(v,image(1:end,1:end,:));
    
end
close(v)

