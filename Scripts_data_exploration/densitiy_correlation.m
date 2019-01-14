specs.A = 'raw'; % raw or binary
specs.measure ='coherence';
[r,densities ]= compute_patient_activity(model,patient_coordinates_007,specs);

v1=densities.left-nanmean(densities.left);
v2=densities.right-nanmean(densities.right);
v3=densities.global-nanmean(densities.global);
v1(isnan(v1))=[];
v2(isnan(v2))=[];
v3(isnan(v3))=[];
r12= xcorr(v1,v2,0,'coeff');
r13= xcorr(v1,v3,0,'coeff');
r23= xcorr(v2,v3,0,'coeff');