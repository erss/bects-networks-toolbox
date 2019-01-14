 
%%% 1. LOAD DATA
model.patient_name ='pBECTS006';
model.data = [data_left; data_right];
pc = patient_coordinates_006;

%%% 2. LOAD MODEL PARAMETERS
model.sampling_frequency = 2035;
model.window_step = 1;% 0.5; % in seconds
model.window_size = 2;   % in seconds
model.q=0.05;
model.nsurrogates = 10000;
model.t=time;

%%% 4. INFER POWER ON DATA WITHOUT MEAN SUBTRACTED
model.data_clean = model.data;
modelNMS = infer_power(model);
psd_NMS = power_in_focus( modelNMS,pc);
f = modelNMS.f;
figure;
ax2=subplot(121);
plot(f,psd_NMS.power_left,'--m')
hold on;
plot(f, psd_NMS.power_right,'--g')
plot(f, psd_NMS.power_combined,'--b')
title('Mean Not Subtacted')
xlim([0 10])
%%% 5. INFER POWER ON DATA *WITH* MEAN SUBTRACTED
data = model.data;
m = mean(data,2);
m = repmat(m,[1 size(data,2)]);
data_mean = data - m;
model.data = data;
model.data_clean=data_mean;

modelMS = infer_power(model);

psd_MS = power_in_focus( modelMS,pc);
f = modelMS.f;
ax1=subplot(122);
plot(f,(psd_MS.power_left),'--m')
hold on;
plot(f,(psd_MS.power_right),'--g')
plot(f,(psd_MS.power_combined),'--b')
title('Mean Subtacted')
xlim([0 10])
linkaxes([ax1,ax2],'xy')


%%%

d= [data_left;data_right];
C = bsxfun(@minus, d1, mean(d1,2));
