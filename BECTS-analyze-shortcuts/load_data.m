%%% Script to load all the data

%% load patient_coordinates
load('/Users/erss/Documents/MATLAB/pBECTS006/patient_coordinates_006.mat')
load('/Users/erss/Documents/MATLAB/pBECTS007/patient_coordinates_007.mat')
load('/Users/erss/Documents/MATLAB/pBECTS020/patient_coordinates_020.mat')
load('/Users/erss/Documents/MATLAB/pBECTS013/patient_coordinates_013.mat')
load('/Users/erss/Documents/MATLAB/pBECTS019/patient_coordinates_019.mat')
load('/Users/erss/Documents/MATLAB/pBECTS003/patient_coordinates_003.mat')
patient_coordinates_006.status ='active-left';
patient_coordinates_007.status ='active-right';
patient_coordinates_020.status ='healthy';
patient_coordinates_013.status ='healthy';
patient_coordinates_003.status ='active-left';
patient_coordinates_019.status ='healthy';


patient_coordinates_020.hand = 'left'; % 
patient_coordinates_013.hand = 'right'; % 
patient_coordinates_006.hand = 'right'; %
patient_coordinates_007.hand = 'right'; %
patient_coordinates_003.hand ='right';
patient_coordinates_019.hand ='right';
%% load cross-correlation networks

load('/Users/erss/Documents/MATLAB/pBECTS_inferred_nets/cross_corr_bootstrap/pBECTS006_sleep07_source.mat')
model006 = model;
clear model
load('/Users/erss/Documents/MATLAB/pBECTS_inferred_nets/cross_corr_bootstrap/pBECTS007_sleep05_source.mat')
model007 = model;
clear model
load('/Users/erss/Documents/MATLAB/pBECTS_inferred_nets/cross_corr_bootstrap/pBECTS013_rest02_source.mat')
model013 = model;
clear model
load('/Users/erss/Documents/MATLAB/pBECTS_inferred_nets/cross_corr_bootstrap/pBECTS020_rest03_source.mat')
model020 = model;
clear model


%% load coherence - r2 networks

load('/Users/erss/Documents/MATLAB/pBECTS_inferred_nets/coherence - r2/pBECTS006_sleep07_coherence_cleaning.mat')
model006 = model;
clear model
load('/Users/erss/Documents/MATLAB/pBECTS_inferred_nets/coherence - r2/pBECTS007_sleep05_coherence_cleaning.mat')
model007 = model;
clear model
load('/Users/erss/Documents/MATLAB/pBECTS_inferred_nets/coherence - r2/pBECTS013_rest02_coherence_cleaning.mat')
model013 = model;
clear model
load('/Users/erss/Documents/MATLAB/pBECTS_inferred_nets/coherence - r2/pBECTS020_rest03_coherence_cleaning.mat')
model020 = model;
clear model



%% load power
load('pBECTS003_rest02_power.mat')
model003 = model;
clear model
load('pBECTS006_power.mat')
model006 = model;
clear model
load('pBECTS007_power.mat')
model007 = model;
clear model
load('pBECTS013_rest02_power.mat')
model013 = model;
clear model
load('pBECTS019_rest01_power.mat')
model019 = model;
clear model
load('pBECTS020_rest05_power.mat')
model020 = model;
clear model

%% load coherence v3 nets BETA
load('/Users/erss/Documents/MATLAB/pBECTS_results/coherence - r3/pBECTS003_rest02_beta.mat')
model003 = model;

clear model

load('/Users/erss/Documents/MATLAB/pBECTS_results/coherence - r3/pBECTS006_sleep07_beta.mat')
model006 = model;
clear model

load('/Users/erss/Documents/MATLAB/pBECTS_results/coherence - r3/pBECTS006_sleep07_beta.mat')
model007 = model;
clear model

load('/Users/erss/Documents/MATLAB/pBECTS_results/coherence - r3/pBECTS013_rest02_beta.mat')
model013 = model;
clear model

load('/Users/erss/Documents/MATLAB/pBECTS_results/coherence - r3/pBECTS019_rest01_beta.mat')
model019 = model;
clear model

load('/Users/erss/Documents/MATLAB/pBECTS_results/coherence - r3/new_patient20_wo_bad_channel/pBECTS020_rest05__coherence_v3.mat')
model020 = model;
clear model




%% load sigma and beta two
load('/Users/erss/Documents/MATLAB/pBECTS_results/coherence - r3/pBECTS007_sleep05_sigma_coherence.mat')
model007_sigma = model_sigma;

load('/Users/erss/Documents/MATLAB/pBECTS_results/coherence - r3/pBECTS007_sleep05_beta_two_coherence.mat')
model007_b2 = model_beta_two;

load('/Users/erss/Documents/MATLAB/pBECTS_results/coherence - r3/pBECTS019_rest01__sigma_coherence.mat')
model019_sigma = model_sigma;

load('/Users/erss/Documents/MATLAB/pBECTS_results/coherence - r3/pBECTS019_rest01__beta_two_coherence.mat')
model019_b2 = model_beta_two;



