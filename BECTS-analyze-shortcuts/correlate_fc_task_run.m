load('/Users/erss/Documents/MATLAB/pBECTS003/patient_coordinates_003.mat')
load('/Users/erss/Documents/MATLAB/pBECTS006/patient_coordinates_006.mat')
load('/Users/erss/Documents/MATLAB/pBECTS013/patient_coordinates_013.mat')
load('/Users/erss/Documents/MATLAB/pBECTS007/patient_coordinates_007.mat')
load('/Users/erss/Documents/MATLAB/pBECTS020/patient_coordinates_020.mat')
load('/Users/erss/Documents/MATLAB/pBECTS019/patient_coordinates_019.mat')
 
patient_coordinates_003.status ='active-left';
patient_coordinates_003.hand ='right';
patient_coordinates_006.status ='active-left';
patient_coordinates_007.status ='active-right';
patient_coordinates_020.status ='healthy';
patient_coordinates_020.hand = 'left'; % DOUBLE CHECK
patient_coordinates_013.status ='healthy';
patient_coordinates_019.hand = 'right';
patient_coordinates_019.status = 'healthy';

%% Load recent data
load('/Users/erss/Documents/MATLAB/pBECTS_inferred_nets/coherence - r3/pBECTS003_rest02__coherence_v3.mat')
model003_02 = model;
clear model

load('/Users/erss/Documents/MATLAB/pBECTS_inferred_nets/coherence - r3/pBECTS003_rest03__coherence_v3.mat')
model003_03 = model;
clear model

load('/Users/erss/Documents/MATLAB/pBECTS_inferred_nets/coherence - r3/pBECTS006_sleep07_coherence_v3.mat')
model006 = model;
clear model

load('/Users/erss/Documents/MATLAB/pBECTS_inferred_nets/coherence - r3/pBECTS007_sleep05_coherence_v3.mat')
model007 = model;
clear model

load('/Users/erss/Documents/MATLAB/pBECTS_inferred_nets/coherence - r3/pBECTS013_rest02__coherence_v3.mat')
model013_02 = model;
clear model

load('/Users/erss/Documents/MATLAB/pBECTS_inferred_nets/coherence - r3/pBECTS013_rest05__coherence_v3.mat')
model013_05 = model;
clear model

load('/Users/erss/Documents/MATLAB/pBECTS_inferred_nets/coherence - r3/pBECTS019_rest01__coherence_v3.mat')
model019_01 = model;
clear model

% load('/Users/erss/Documents/MATLAB/pBECTS_inferred_nets/coherence - r3/pBECTS020_rest03__coherence_v3.mat')
% model020_03 = model;
% clear model
% 
% load('/Users/erss/Documents/MATLAB/pBECTS_inferred_nets/coherence - r3/pBECTS020_rest04__coherence_v3.mat')
% model020_04 = model;
% clear model

%%
load('/Users/erss/Documents/MATLAB/pBECTS_inferred_nets/coherence - r3/new_patient20_wo_bad_channel/pBECTS020_rest05__coherence_v3.mat')
model020_05 = model;
clear model

load('/Users/erss/Documents/MATLAB/pBECTS_inferred_nets/coherence - r3/new_patient20_wo_bad_channel/pBECTS020_rest06__coherence_v3.mat')
model020_06 = model;
clear model

