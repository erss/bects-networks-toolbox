%% Compute dynamic densities and plots

specs.A = 'binary'; % raw or binary
specs.measure ='coherence';

[r,densities ]= compute_dynamic_densities(model006,patient_coordinates_006,specs);
suptitle('patient 006 - active left')

[r,densities ]= compute_dynamic_densities(model007,patient_coordinates_007,specs);
suptitle('patient 007 - active right')

[r,densities ]= compute_dynamic_densities(model013,patient_coordinates_013,specs);
suptitle('patient 013 - healthy')

[r,densities ]= compute_dynamic_densities(model020,patient_coordinates_020,specs);
suptitle('patient 20 - healthy')