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

load('/Users/erss/Documents/MATLAB/pBECTS_inferred_nets/coherence - r1/pBECTS019_rest01_coherence.mat')
model019=model;
clear model;
load('/Users/erss/Documents/MATLAB/pBECTS_inferred_nets/coherence - r1/pBECTS006_coherence.mat')
model006 =model;
clear model
load('/Users/erss/Documents/MATLAB/pBECTS_inferred_nets/coherence - r1/pBECTS007_coherence.mat')
model007 =model;
clear model
load('/Users/erss/Documents/MATLAB/pBECTS_inferred_nets/coherence - r1/pBECTS013_rest02_coherence.mat')
model013 =model;
clear model
load('/Users/erss/Documents/MATLAB/pBECTS_inferred_nets/coherence - r1/pBECTS020_coherence.mat')
model020=model;
clear model
load('/Users/erss/Documents/MATLAB/pBECTS_inferred_nets/coherence - r1/pBECTS003_coherence.mat')
model003=model;
clear model;
%%

specs.A= 'binary'
specs.measure= 'coherence'
specs.normalize= 'false'

correlate_fc_task


%% cross cor

load('/Users/erss/Documents/MATLAB/pBECTS006/patient_coordinates_006.mat')
load('/Users/erss/Documents/MATLAB/pBECTS013/patient_coordinates_013.mat')
load('/Users/erss/Documents/MATLAB/pBECTS007/patient_coordinates_007.mat')
 load('/Users/erss/Documents/MATLAB/pBECTS020/patient_coordinates_020.mat')
 patient_coordinates_006.status ='active-left';
patient_coordinates_007.status ='active-right';
patient_coordinates_020.status ='healthy';
patient_coordinates_020.hand = 'left'; % DOUBLE CHECK: left is listed on sheet
                                        % but he performed faster with
                                        % right hand
patient_coordinates_013.status ='healthy';

 
 
load('/Users/erss/Documents/MATLAB/pBECTS_inferred_nets/cross_corr_bootstrap/pBECTS007_sleep05_source.mat')
model007=model;
load('/Users/erss/Documents/MATLAB/pBECTS_inferred_nets/cross_corr_bootstrap/pBECTS013_rest02_source.mat')
model013=model;
load('/Users/erss/Documents/MATLAB/pBECTS_inferred_nets/cross_corr_bootstrap/pBECTS006_sleep07_source.mat')
model006=model;
load('/Users/erss/Documents/MATLAB/pBECTS_inferred_nets/cross_corr_bootstrap/pBECTS020_rest03_source.mat')
model020=model;

specs.A= 'binary'
specs.measure= 'xcorr'
specs.normalize= 'false'

correlate_fc_task