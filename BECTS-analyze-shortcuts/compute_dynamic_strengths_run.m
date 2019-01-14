%%% compute_dynamic_densities scripts + plots
specs.normalize = 'true'; % true or false
specs.A = 'raw'; % raw or binary
specs.measure ='coherence';
%%
dyn3_02    = compute_dynamic_strength(model003_02,patient_coordinates_003,specs);
dyn3_03    = compute_dynamic_strength(model003_03,patient_coordinates_003,specs);
dyn6    = compute_dynamic_strength(model006,patient_coordinates_006,specs);
dyn7    = compute_dynamic_strength(model007,patient_coordinates_007,specs);
dyn1302 = compute_dynamic_strength(model013_02,patient_coordinates_013,specs);
dyn1305 = compute_dynamic_strength(model013_05,patient_coordinates_013,specs);
dyn1901 = compute_dynamic_strength(model019_01,patient_coordinates_019,specs);
dyn2003   = compute_dynamic_strength(model020_03,patient_coordinates_020,specs);
dyn2004   = compute_dynamic_strength(model020_03,patient_coordinates_020,specs);
dyn2005   = compute_dynamic_strength(model020_03,patient_coordinates_020,specs);
dyn2006   = compute_dynamic_strength(model020_03,patient_coordinates_020,specs);

%% Plot focus to focus activity
figure; hold on;
plot(1:237,dyn1305.pre_post,'m')
plot(1:238,dyn2004.pre_post,'b')
plot(1:237,dyn3_02.pre_post,'k')
plot(1:236,dyn7.pre_post,'g')
plot(1:237,nanmean(dyn1305.pre_post)*ones(1,237),'m')
plot(1:238,nanmean(dyn2004.pre_post)*ones(1,238),'b')
plot(1:237,nanmean(dyn3_02.pre_post)*ones(1,237),'k')
plot(1:236,nanmean(dyn7.pre_post)*ones(1,236),'g')

legend('13','20','3','7')

figure; hold on;
histogram(dyn1305.pre_post,'FaceColor','m')
histogram(dyn2004.pre_post,'FaceColor','b')
histogram(dyn3_02.pre_post,'FaceColor','k')
histogram(dyn7.pre_post,'FaceColor','g')
