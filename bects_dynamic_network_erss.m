% DYANMIC NETWORK SCRIPT EXAMPLE
% 0. SET PARAMETERS

%OUTFIGPATH = strcat('~/Desktop/bects_data/plots/',model.patient_name);
%OUTVIDPATH = strcat('~/Desktop/',model.patient_name,'.avi');
%OUTDATAPATH = strcat('~/Desktop/',model.patient_name,'.mat');
%OUTDATAPATH = strcat('~/Documents/MATLAB/',model.patient_name,'.mat');
% OUTFIGPATH = strcat('~/Documents/MATLAB/',model.patient_name(1:9),'/');
% patient_coordinates = load_patient_coordinates( model.patient_name );
% % % 1. LOAD DATA
model.patient_name ='model013';
model.data = [data_left;data_right];
% % 2. LOAD MODEL PARAMETERS
model.sampling_frequency = 2035;
%model.t = 1:1/model.sampling_frequency:size(model.data,2)/model.sampling_frequency;
model.window_step = 1;% 0.5; % in seconds
model.window_size = 2;   % in seconds
model.q=0.05;
model.nsurrogates = 10000;
model.t=time;
% % 3. Remove artifacts
model = remove_artifacts_all_lobes(model,patient_coordinates_013);
% 3a. INFER NETWORK
 %[ model ] = infer_network_correlation_bootstrap( model);
model013 = infer_network_imaginary_coherency_2(model);

% 3b. SAVE DATA
 model013.data = NaN;  % clear data
 model013.data_clean = NaN;  % clear data
 save('model013_IC_C.mat','model013')
%%
% % 4a. ANALYZE NETWORK - density
%  [r,densities] = compute_network_densities(model.C,patient_coordinates);
% % saveas(figure(1),[OUTFIGPATH 'histogram.jpg'])
% % saveas(figure(2),[OUTFIGPATH 'density_over_time.jpg'])
%  close all;
% 
% % % 4a. ANALYZE NETWORK - high density
% data = [data_left;data_right];
% m = mean(data,2);
% m = repmat(m,[1 size(data,2)]);
% data = data - m;
% model.data_mn = data;
% 
% [~, i] = max(densities.left);
% plot_spectrogram(model,patient_coordinates,i)
% saveas(figure(1),[OUTFIGPATH 'channels_high_left.jpg'])
% title('high left')
% close all;
% 
% [~, i] = max(densities.right);
% plot_spectrogram(model,patient_coordinates,i)
% saveas(figure(1),[OUTFIGPATH 'channels_high_right.jpg'])
% title('high right')
% close all;
% 
% % % 4b. ANALYZE NETWORK - low density
% 
% [~, i] = min(densities.left);
% plot_spectrogram(model,patient_coordinates,i)
% saveas(figure(1),[OUTFIGPATH 'channels_low_left.jpg'])
% title('low left')
% close all;
% 
% [~, i] = min(densities.right);
% plot_spectrogram(model,patient_coordinates,i)
% saveas(figure(1),[OUTFIGPATH 'channels_low_right.jpg'])
% title('low right')
% close all;
% % % 4c. ANALYZE NETWORK - global, high
% [~, k] = max(densities.global);
% 
% t = model.t;
% window_step = 0.5;
% window_size = 1;
% t_start = t(1) + (k-1) * window_step;   %... get window start time [s],
% t_stop  = t_start + window_size;                  %... get window stop time [s],
% indices = t >= t_start & t < t_stop;
% figure;
% subplot(1,2,1)
% plotchannels(data_left(:,indices)');
% title('all left')
% subplot(1,2,2)
% plotchannels(data_right(:,indices)');
% title('all right ')
% 
% 
% saveas(figure(1),[OUTFIGPATH 'channels_high_global.jpg'])
% title('high global')
% close all;

% % 4c. ANALYZE NETWORK - mid density
% [x,k] =sort(densities.global);
% i = floor(length(k)/2);
% i = k(i);
% plot_spectrogram(model,patient_coordinates,i)
% saveas(figure(1),[OUTFIGPATH 'spectrogram_mid_global.jpg'])
% saveas(figure(2),[OUTFIGPATH 'channels_mid_global.jpg'])
% close all;


% figure;
% plot(lag,r);
% saveas(figure(2),[OUTFIGPATH '_xcorr_of_density.fig'])
% saveas(figure(2),[OUTFIGPATH '_xcorr_of_density.jgp'])
% close all

% 4b. ANALYZE NETWORK - degree centrality
% compute_network_centralities(model.C,patient_coordinates)
% saveas(figure(2),[OUTFIGPATH '_centrality.fig'])
%close all

% 4c. ANALYZE NETWORK - density by distance
% compute_network_densities_by_distance(model.C,patient_coordinates);
% saveas(figure(1),[OUTFIGPATH '_density_by_distance.fig'])
% saveas(figure(1),[OUTFIGPATH '_density_by_distance.jpg'])
% close all