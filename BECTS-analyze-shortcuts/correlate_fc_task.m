specs.normalize = 'false'; % true or false
specs.A = 'raw'; % raw or binary

avg6 = compute_average_strength( model006,patient_coordinates_006,specs );
avg7 = compute_average_strength( model007,patient_coordinates_007,specs );
avg1302 = compute_average_strength( model013_rest02,patient_coordinates_013,specs );
avg1305 = compute_average_strength( model013_rest05,patient_coordinates_013,specs );
avg20 = compute_average_strength( model020,patient_coordinates_020,specs );

labels = {'6','7','13','20'};  
rowD = [112,78,24,81];
rowE = [-1.87,0.07,1.53,-1.93];
%%
%%% Plot active in blue
% rowD square
% rowE *

figure;
subplot 121
plot([avg6.kPrPo avg7.kPrPo],rowD(1:2),'sb');
hold on;
plot([mean([avg1302.kPrPo,avg1305.kPrPo]) avg20.kPrPo],rowD(3:4),'sr');
title('Row D')
xlabel('functional connectivity')
ylabel('GPDBdomRaw')

%%% Plot healthy in red
% rowD square
% rowE *
 subplot 122
plot([avg6.kPrPo avg7.kPrPo],rowE(1:2),'*b');
hold on;
plot([mean([avg1302.kPrPo,avg1305.kPrPo]) avg20.kPrPo],rowE(3:4),'*r');
title('Row E')
xlabel('functional connectivity')
ylabel('GPDBdomZ')