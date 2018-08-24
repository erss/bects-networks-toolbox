%%% Script to load all the data

load('/Users/erss/Documents/MATLAB/pBECTS006/patient_coordinates_006.mat')
load('/Users/erss/Documents/MATLAB/pBECTS007/patient_coordinates_007.mat')
load('/Users/erss/Documents/MATLAB/pBECTS020/patient_coordinates_020.mat')
load('/Users/erss/Documents/MATLAB/pBECTS013/patient_coordinates_013.mat')

patient_coordinates_006.status ='active-left';
patient_coordinates_007.status ='active-right';
patient_coordinates_020.status ='healthy';
patient_coordinates_013.status ='healthy';

load('/Users/erss/Documents/MATLAB/pBECTS_lag_long (original)/ccbootstrap_maxlags20/pBECTS006_sleep07_source.mat')
model006 = model;
clear model
load('/Users/erss/Documents/MATLAB/pBECTS_lag_long (original)/ccbootstrap_maxlags20/pBECTS007_sleep05_source.mat')
model007 = model;
clear model
load('/Users/erss/Documents/MATLAB/pBECTS_lag_long (original)/ccbootstrap_maxlags20/pBECTS013_rest02_source.mat')
model013_rest02 = model;
clear model
load('/Users/erss/Documents/MATLAB/pBECTS_lag_long (original)/ccbootstrap_maxlags20/pBECTS013_rest05_source.mat')
model013_rest05 = model;
clear model
load('/Users/erss/Documents/MATLAB/pBECTS_lag_long (original)/maxlags_20/pBECTS020_rest03_source.mat.mat')
model020 = model;
clear model