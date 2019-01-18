specs.A= 'binary'
specs.measure= 'coherence'
specs.normalize= 'false'
figure; hold on;
avg3_02 = compute_average_strength( model003_02,patient_coordinates_003,specs );
avg3_03 = compute_average_strength( model003_03,patient_coordinates_003,specs );

plot(avg3_02.kPrPo,84,'sb','MarkerSize',5,'MarkerFaceColor','b')
text(avg3_02.kPrPo + 0.007, 84 +0.007, '0302')
plot(avg3_03.kPrPo,84,'sb','MarkerSize',5,'MarkerFaceColor','b')
text(avg3_03.kPrPo + 0.007, 84 +0.007, '0303')
 
plot(mean([avg3_02.kPrPo,avg3_03.kPrPo]),84,'sb','MarkerSize',15,'MarkerFaceColor','b')
text(mean([avg3_02.kPrPo,avg3_03.kPrPo]) + 0.007, 84 +0.007, 'mean 3')


avg6 = compute_average_strength( model006,patient_coordinates_006,specs );
plot(avg6.kPrPo,112,'sb','MarkerSize',15,'MarkerFaceColor','b')
text(avg6.kPrPo + 0.007, 112 +0.007, '6')

avg7 = compute_average_strength( model007,patient_coordinates_007,specs );
plot(avg7.kPrPo,78,'sb','MarkerSize',15,'MarkerFaceColor','b')
text(avg7.kPrPo + 0.007, 78 +0.007, '7')

avg1302 = compute_average_strength( model013_02,patient_coordinates_013,specs );
avg1305 = compute_average_strength( model013_05,patient_coordinates_013,specs );
plot(avg1302.kPrPo,24,'sr','MarkerSize',5)
plot(avg1305.kPrPo,24,'sr','MarkerSize',5)
text(avg1302.kPrPo + 0.007, 24 +0.007, '1302')
text(avg1305.kPrPo + 0.007, 24 +0.007, '1303')
plot(mean([avg1302.kPrPo avg1305.kPrPo]),24,'sr','MarkerSize',15)
text(mean([avg1302.kPrPo avg1305.kPrPo]) + 0.007, 24 +0.007, 'mean 13')

avg1901 = compute_average_strength( model019_01,patient_coordinates_019,specs );
plot(avg1901.kPrPo,62,'sr','MarkerSize',15)
text(avg1901.kPrPo + 0.007, 62 +0.007, '19')
% avg20_03 = compute_average_strength( model020_03,patient_coordinates_020,specs );
% avg20_04 = compute_average_strength( model020_04,patient_coordinates_020,specs );
avg20_05 = compute_average_strength( model020_05,patient_coordinates_020,specs );
avg20_06 = compute_average_strength( model020_06,patient_coordinates_020,specs );
% plot(avg20_03.kPrPo,81,'sr','MarkerSize',5)
% plot(avg20_04.kPrPo,81,'sr','MarkerSize',5)
plot(avg20_05.kPrPo,81,'sr','MarkerSize',5)
plot(avg20_06.kPrPo,81,'sr','MarkerSize',5)
% text(avg20_03.kPrPo + 0.007, 81 +0.007, '2003')
% text(avg20_04.kPrPo + 0.007, 81 +0.007, '20')
text(avg20_05.kPrPo + 0.007, 81 +0.007, '20')
text(avg20_06.kPrPo + 0.007, 81 +0.007, '20')
% 
% m1= mean([avg20_03.kPrPo avg20_04.kPrPo avg20_05.kPrPo avg20_06.kPrPo]);
% plot(m1,81,'sr','MarkerSize',15)
% text(m1 + 0.007, 81 +0.007, 'mean 20')
axis square
set(gca,'FontSize',18)
title('Task Performance vs Mean Raw Coherence','FontSize',20)
xlabel('Raw Mean Coherence','FontSize',20)
%xlabel('Mean Network Density','FontSize',20)
ylabel('Time to Complete Task (s)','FontSize',20)
box off
%%
labels = {'3','6','7','13','20','19'};  
rowD =   [84, 112, 78, 24,  81, 62];
rowE = [-1.73,-1.87,0.07,1.53,-1.93,0.27];
pwr = [3.6, 2.31, 1.16,1.32, 5.6,3.88];

plot(pwr,rowD,'sq')