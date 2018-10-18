%%% Script to load all the data

%% load patient 6

%% load patient 7

%% load patient 13

%% load patient 20
load('/Users/erss/Documents/MATLAB/pBECTS006/patient_coordinates_006.mat')
load('/Users/erss/Documents/MATLAB/pBECTS007/patient_coordinates_007.mat')
load('/Users/erss/Documents/MATLAB/pBECTS020/patient_coordinates_020.mat')
load('/Users/erss/Documents/MATLAB/pBECTS013/patient_coordinates_013.mat')

patient_coordinates_006.status ='active-left';
patient_coordinates_007.status ='active-right';
patient_coordinates_020.status ='healthy';
patient_coordinates_013.status ='healthy';

patient_coordinates_020.hand = 'left'; % 
patient_coordinates_013.hand = 'right'; % 
patient_coordinates_006.hand = 'right'; %
patient_coordinates_007.hand = 'right'; % 

% 
% load('/Users/erss/Documents/MATLAB/pBECTS_lag_long (original)/ccbootstrap_maxlags20/pBECTS006_sleep07_source.mat')
% model006 = model;
% clear model
% load('/Users/erss/Documents/MATLAB/pBECTS_lag_long (original)/ccbootstrap_maxlags20/pBECTS007_sleep05_source.mat')
% model007 = model;
% clear model
% load('/Users/erss/Documents/MATLAB/pBECTS_lag_long (original)/ccbootstrap_maxlags20/pBECTS013_rest02_source.mat')
% model013 = model;
% clear model
% % load('/Users/erss/Documents/MATLAB/pBECTS_lag_long (original)/ccbootstrap_maxlags20/pBECTS013_rest05_source.mat')
% % model013_rest05 = model;
% % clear model
% load('/Users/erss/Documents/MATLAB/pBECTS_lag_long (original)/ccbootstrap_maxlags20/pBECTS020_rest03_source.mat')
% model020 = model;
% clear model

load('/Users/erss/Documents/MATLAB/pBECTS_inferred_nets/coherence/pBECTS006_coherence.mat')
model006 = model;
clear model
load('/Users/erss/Documents/MATLAB/pBECTS_inferred_nets/coherence/pBECTS007_coherence.mat')
model007 = model;
clear model
load('/Users/erss/Documents/MATLAB/pBECTS_inferred_nets/coherence/pBECTS013_rest02_coherence.mat')
model013 = model;
clear model
load('/Users/erss/Documents/MATLAB/pBECTS_inferred_nets/coherence/pBECTS020_coherence.mat')
model020 = model;
clear model



