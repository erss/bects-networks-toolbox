%% Compute dynamic densities and plots



load('/Users/erss/Documents/MATLAB/pBECTS006/pBECTS006_sleep07_source.mat');
model006.data = [data_left;data_right];
model006 = remove_artifacts_all_lobes(model006,patient_coordinates_006);
%%
specs.A = 'raw'; % raw or binary
model006.mx0=model006.kIC_beta;
[r,densities ]= compute_dynamic_densities(model006,patient_coordinates_006,specs);
%%
load('/Users/erss/Documents/MATLAB/pBECTS013/sleep_source/pBECTS013_rest02_source.mat')
model013_rest02.data = [data_left;data_right];
model013_rest02 = remove_artifacts_all_lobes(model013_rest02,patient_coordinates_013);
[r,densities ]= compute_dynamic_densities(model013_rest02,patient_coordinates_013);


load('/Users/erss/Documents/MATLAB/pBECTS007/pBECTS007_sleep05_source.mat')
model007.data = [data_left;data_right];
model007 = remove_artifacts_all_lobes(model007,patient_coordinates_007);
[r,densities ]= compute_dynamic_densities(model007,patient_coordinates_007);
load('/Users/erss/Documents/MATLAB/pBECTS020/pBECTS020_rest03_source.mat')
model020.data = [data_left;data_right];
model020 = remove_artifacts_all_lobes(model020,patient_coordinates_020);
[r,densities ]= compute_dynamic_densities(model020,patient_coordinates_020);