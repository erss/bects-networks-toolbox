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

[LN,RN]   = find_subnetwork_central( pc);

%%% Delta: [1 4]; Theta: [4 8]; Alpha: [8 12]; 
%%% Sigma: [12 15]; Beta: [15 30]; Gamma: [30 50]
% Filter data - focus
dFocus = data([LN;RN],:);
ydelta = lsfilter(dFocus',2035,[1 4]);
ytheta = lsfilter(dFocus',2035,[4 8]);
yalpha = lsfilter(dFocus',2035,[8 12]);
ysigma = lsfilter(dFocus',2035,[12 15]);
ybeta  = lsfilter(dFocus',2035,[15 30]);

dFocus = dFocus';


%% Clean filtered data

% t_indicator = double(isfinite(model.t_clean));
% t_indicator(t_indicator==0) = nan;
% 
% data_clean = bsxfun(@times,y,t_indicator');
% %data_cleant = bsxfun(@times,yt,t_indicator');
% %% Visualize filtered data
% % dL = data_clean(:,1:length(LN));
% % dR = data_clean(:,length(LN)+1:end);
% % 
% % dLt = data_cleant(:,1:length(LNt));
% % dRt = data_cleant(:,length(LNt)+1:end);
% 
% dL = data_clean(:,LN);
% dR = data_clean(:,RN);



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
        subplot(2,3,1)
        plotchannels(t(indices),dFocus(indices,:));
        title('Unfiltered')
        axis square
        subplot(2,3,2)
        plotchannels(t(indices),ytheta(indices,:));
        title('Theta')
        axis square
       
        
        subplot(2,3,3)
        plotchannels(t(indices),yalpha(indices,:));
        title('Alpha')
        axis square
        subplot(2,3,4)
        plotchannels(t(indices),ysigma(indices,:));
        title('Sigma')
        axis square
        
        subplot(2,3,5)
        plotchannels(t(indices),ybeta(indices,:));
        title('Beta')
        axis square
      
        
        drawnow
        if sum(indices(right_events)) >0
          suptitle(['SPIKE in right'])
        elseif sum(indices(left_events))>0
          suptitle(['SPIKE in left'])
        else
        suptitle(['Index: ' num2str(k)])
        end
        
        F = getframe(h);
        image = F.cdata;
        writeVideo(v,image(1:end,1:end,:));
    
end
close(v)

