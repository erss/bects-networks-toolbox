
avg3 = compute_average_strength( model003,patient_coordinates_003,specs );

avg6 = compute_average_strength( model006,patient_coordinates_006,specs );
avg7 = compute_average_strength( model007,patient_coordinates_007,specs );
avg1302 = compute_average_strength( model013,patient_coordinates_013,specs );
% avg1305 = compute_average_strength( model013_rest05,patient_coordinates_013,specs );
 avg20 = compute_average_strength( model020,patient_coordinates_020,specs );
 avg19 = compute_average_strength( model019,patient_coordinates_019,specs );

labels = {'3','6','7','13','20','19'};  
rowD = [84,112,78,24,81, 62];
rowE = [-1.73,-1.87,0.07,1.53,-1.93,0.27];
%%
%%% Plot active in blue
% rowD square
% rowE *

% figure;
% subplot 121
% plot([avg6.kPrPo avg7.kPrPo],rowD(1:2),'sb');
% hold on;
% plot([mean([avg1302.kPrPo,avg1305.kPrPo]) avg20.kPrPo],rowD(3:4),'sr');
% title('Row D')
% xlabel('functional connectivity')
% ylabel('GPDBdomRaw')
% 
% %%% Plot healthy in red
% % rowD square
% % rowE *
%  subplot 122
% plot([avg6.kPrPo avg7.kPrPo],rowE(1:2),'*b');
% hold on;
% plot([mean([avg1302.kPrPo,avg1305.kPrPo]) avg20.kPrPo],rowE(3:4),'*r');
% title('Row E')
% xlabel('functional connectivity')
% ylabel('GPDBdomZ')

%%
figure;
plot([avg3.kPrPo],rowD(1),'sb','MarkerSize',15,'MarkerFaceColor','b');
hold on;
plot([avg1302.kPrPo],rowD(4),'*r','MarkerSize',15);
plot([avg3.kPrPo avg6.kPrPo avg7.kPrPo],rowD(1:3),'sb','MarkerSize',15,'MarkerFaceColor','b');
hold on
plot([avg1302.kPrPo avg20.kPrPo avg19.kPrPo],rowD(4:end),'*r','MarkerSize',15);
h=legend('Active BECTS','Healthy Controls')
legend boxoff
set(h,'FontSize',16)
% text(avg3.kPrPo + 0.007, rowD(1) +0.007, '3')
% 
% text(avg6.kPrPo + 0.007, rowD(2) +0.007, '6')
% text(avg7.kPrPo + 0.007, rowD(3) +0.007, '7')
% text(avg1302.kPrPo + 0.007, rowD(4) +0.007, '13')
% text(avg20.kPrPo + 0.007, rowD(5) +0.007, '20')
% text(avg19.kPrPo + 0.007, rowD (6) +0.007, '19')
axis square
set(gca,'FontSize',18)
title('Task Performance vs Density of Network Connections','FontSize',20)
xlabel('Density of Averaged Network','FontSize',20)
ylabel('Time to Complete Task (s)','FontSize',20)
box off
%ylabel('GPDBdomRaw')
%%
%%% Plot healthy in red
% rowD square
% rowE *
figure;
plot([avg3.kPrPo avg6.kPrPo avg7.kPrPo],rowE(1:3),'*b');
hold on;
plot([avg1302.kPrPo avg20.kPrPo avg19.kPrPo ] ,rowE(4:end),'*r');
% text(avg3.kPrPo + 0.007, rowE(1) +0.007, '3')
% 
% text(avg6.kPrPo + 0.007, rowE(2) +0.007, '6')
% text(avg7.kPrPo + 0.007, rowE(3) +0.007, '7')
% text(avg1302.kPrPo + 0.007, rowE(4) +0.007, '13')
% text(avg20.kPrPo + 0.007, rowE (5) +0.007, '20')
% text(avg19.kPrPo + 0.007, rowE (6) +0.007, '19')
axis square
title('Row E')
xlabel('functional connectivity')
ylabel('GPDBdomZ')

% figure;
% subplot 121
% plot([avg6.kPrPo avg7.kPrPo],rowD(1:2),'sb');
% hold on;
% plot([avg1302.kPrPo],rowD(3:3),'sr');
% title('Row D')
% xlabel('functional connectivity')
% ylabel('GPDBdomRaw')
% 
% %%% Plot healthy in red
% % rowD square
% % rowE *
%  subplot 122
% plot([avg6.kPrPo avg7.kPrPo],rowE(1:2),'*b');
% hold on;
% plot([avg1302.kPrPo ] ,rowE(3:3),'*r');
% title('Row E')
% xlabel('functional connectivity')
% ylabel('GPDBdomZ')