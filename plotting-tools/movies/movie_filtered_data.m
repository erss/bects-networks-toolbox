% Plots filtered data in left and right SOZs and in the temporal lobe, and
% corresponding networks.

% NOTE: We are analyzing BETA, but possible bands for interest could be:
% delta (1-4 Hz), theta (4-8 Hz), alpha (8-12 Hz), beta (12-30 Hz), 
% gamma (30-50 Hz)

% Load filter
addpath(genpath(['Dynanets/2-preprocess']))
addpath(genpath(['Toolboxes/mgh']))
pc=patient_coordinates_006;

data =[data_left;data_right];

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

% Filter data - focus
% dFocus = data([LN;RN],:);
% tic
% y = lsfilter(dFocus',2035,[12 30]);
% filttime=toc;
% 
% % Filter data - temporal
% dTemporal = data([LNt;RNt],:);
% tic
% yt = lsfilter(dTemporal',2035,[12 30]);
% filttimet=toc;

% Filter everything
tic
y = lsfilter(data',2035,[12 30]);
filttimet=toc;



%% Clean filtered data

t_indicator = double(isfinite(model.t_clean));
t_indicator(t_indicator==0) = nan;

data_clean = bsxfun(@times,y,t_indicator');
%data_cleant = bsxfun(@times,yt,t_indicator');
%% Visualize filtered data
% dL = data_clean(:,1:length(LN));
% dR = data_clean(:,length(LN)+1:end);
% 
% dLt = data_cleant(:,1:length(LNt));
% dRt = data_cleant(:,length(LNt)+1:end);

dL = data_clean(:,LN);
dR = data_clean(:,RN);

dLp = data_clean(:,LNp);
dRp = data_clean(:,RNp);

dLo = data_clean(:,LNo);
dRo = data_clean(:,RNo);

dLf = data_clean(:,LNf);
dRf = data_clean(:,RNf);

dLt = data_clean(:,LNt);
dRt = data_clean(:,RNt);

OUTVIDPATH1 = strcat('~/Desktop/',model.patient_name,'_filtered_data.avi');
v = VideoWriter(OUTVIDPATH1);
v.FrameRate=1;
open(v);

t = model.t;
t_clean = model.t_clean;
window_step = 1;
window_size =2;
i_total = 1+floor((t(end)-t(1)-window_size) /window_step);  % # intervals.
h = figure('units','normalized','outerposition',[0 1 1 0.75]);
for k = 1:i_total %length(t_clean)
    t_start = t(1) + (k-1) * window_step;   %... get window start time [s],
    t_stop  = t_start + window_size;                  %... get window stop time [s],
    indices = t >= t_start & t < t_stop;
    
   
        figure(h)
        subplot(2,6,1)
        plotchannels(t(indices),dL(indices,:));
        title('Left Channels')
        axis square
        subplot(2,6,7)
        plotchannels(t(indices),dR(indices,:));
        title('Right Channels')
        axis square
        h1=subplot(2,6,6);
        plotNetwork(model.net_coh([LN;RN],[LN;RN],k),h1)
        
        subplot(2,6,2)
        plotchannels(t(indices),dLt(indices,:));
        title('Left Temporal Channels')
        axis square
        subplot(2,6,8)
        plotchannels(t(indices),dRt(indices,:));
        title('Right Temporal Channels')
        axis square
        
        subplot(2,6,3)
        plotchannels(t(indices),dLp(indices,:));
        title('Left Parietal Channels')
        axis square
        subplot(2,6,9)
        plotchannels(t(indices),dRp(indices,:));
        title('Right Parietal Channels')
        axis square
        
            subplot(2,6,4)
        plotchannels(t(indices),dLo(indices,:));
        title('Left Occipital Channels')
        axis square
        subplot(2,6,10)
        plotchannels(t(indices),dRo(indices,:));
        title('Right Occiptial Channels')
        axis square
        
            subplot(2,6,5)
        plotchannels(t(indices),dLf(indices,:));
        title('Left Frontal Channels')
        axis square
        subplot(2,6,11)
        plotchannels(t(indices),dRf(indices,:));
        title('Right Frontal Channels')
        axis square
        
        
        drawnow
        if indices(60366)
          suptitle(['SPIKE'])
        else
        suptitle(['Index: ' num2str(k)])
        end
        
        F = getframe(h);
        image = F.cdata;
        writeVideo(v,image(1:end,1:end,:));
    
end
close(v)

