% DYANMIC NETWORK SCRIPT EXAMPLE
% 0. SET PARAMETERS
model.patient_name = 'pBECTS007_sleep05';
OUTFIGPATH = strcat('~/Desktop/bects_data/plots/',model.patient_name);
OUTVIDPATH = strcat('~/Desktop/',model.patient_name,'.avi');
OUTDATAPATH = strcat('~/Desktop/',model.patient_name,'.mat');

patient_coordinates.LDL = left_desikan_label;
patient_coordinates.RDL = right_desikan_label;
patient_coordinates.coords = pBECTS007_sourcespace_324pts;
patient_coordinates.left_focus = [source_in_left_pos source_in_left_pre];
patient_coordinates.right_focus = [source_in_right_pos source_in_right_pre];
 

% 1. LOAD DATA
model.data = [data_left;data_right];

% 2. LOAD MODEL PARAMETERS
model.sampling_frequency = 2035;
model.t = 1:1/model.sampling_frequency:size(data,2)/model.sampling_frequency;
model.window_step = 0.5; % in seconds
model.window_size = 1;   % in seconds
model.q=0.05;
model.nsurrogates = 10000;

% 3a. INFER NETWORK
if ~exist('model.C')
    [ model ] = infer_network_correlation_bootstrap( model);
end

% 3b. SAVE DATA
model.data = NaN;  % clear data
save(OUTDATAPATH,'model')

% 4a. ANALYZE NETWORK - density
compute_network_densities(model.C,patient_coordinates)
saveas(figure(1),[OUTFIGPATH '_density.fig'])

% 4b. ANALYZE NETWORK - degree centrality
compute_network_centralities(model.C,patient_coordinates)
saveas(figure(2),[OUTFIGPATH '_centrality.fig'])
close all
