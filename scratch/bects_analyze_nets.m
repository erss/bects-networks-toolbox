load('/Users/erss/Documents/MATLAB/pBECTS006/patient_coordinates_006.mat')
load('/Users/erss/Documents/MATLAB/pBECTS007/patient_coordinates_007.mat')
load('/Users/erss/Documents/MATLAB/pBECTS020/patient_coordinates_020.mat')
% patient_coordinates_006.coords(2,:) = patient_coordinates_006.coords(2,:)...
%     + ones(size(patient_coordinates_006.coords(2,:)));
%
% patient_coordinates_007.coords(2,:) = patient_coordinates_007.coords(2,:)...
%     + ones(size(patient_coordinates_007.coords(2,:)));
%
% patient_coordinates_020.coords(2,:) = patient_coordinates_020.coords(2,:)...
%     + ones(size(patient_coordinates_020.coords(2,:)));

load('/Users/erss/Documents/MATLAB/pBECTS013/patient_coordinates_013.mat')
load('/Users/erss/Documents/MATLAB/pBECTS_lag_long (original)/ccbootstrap_maxlags20/pBECTS006_sleep07_source.mat')
model006 = model;
load('/Users/erss/Documents/MATLAB/pBECTS_lag_long (original)/ccbootstrap_maxlags20/pBECTS007_sleep05_source.mat')
model007 = model;
load('/Users/erss/Documents/MATLAB/pBECTS_lag_long (original)/ccbootstrap_maxlags20/pBECTS013_rest02_source.mat')
model013_rest02 = model;
load('/Users/erss/Documents/MATLAB/pBECTS_lag_long (original)/ccbootstrap_maxlags20/pBECTS013_rest05_source.mat')
model013_rest05 = model;
load('/Users/erss/Documents/MATLAB/pBECTS020/pBECTS020_rest03_source.mat')
load('/Users/erss/Documents/MATLAB/pBECTS_lag_long (original)/maxlags_20/pBECTS020_rest03_source.mat.mat')
model020 = model;
%%
dyn6=compute_dynamic_strength(model006,patient_coordinates_006);
dyn7=compute_dynamic_strength(model007,patient_coordinates_007);
dyn1302=compute_dynamic_strength(model013_rest02,patient_coordinates_013);
dyn1305=compute_dynamic_strength(model013_rest05,patient_coordinates_013);
dyn20=compute_dynamic_strength(model020,patient_coordinates_020);

%% Plot focus to focus activity

figure;
subplot 121
plot(model006.dynamic_network_taxis,dyn6.focus,'k');
hold on;
plot(model007.dynamic_network_taxis,dyn7.focus,'r');
plot(model013_rest02.dynamic_network_taxis,dyn1302.focus,'g');
plot(model013_rest05.dynamic_network_taxis,dyn1305.focus,'c');
plot(model020.dynamic_network_taxis,dyn20.focus,'y');

t=model006.dynamic_network_taxis;
plot([t(1) t(end)],[nanmean(dyn6.focus) nanmean(dyn6.focus)],'k','LineWidth',2);
t=model007.dynamic_network_taxis;
plot([t(1) t(end)],[nanmean(dyn7.focus) nanmean(dyn7.focus)],'r','LineWidth',2);
t=model013_rest02.dynamic_network_taxis;
plot([t(1) t(end)],[nanmean(dyn1302.focus) nanmean(dyn1302.focus)],'g','LineWidth',2);
t=model013_rest05.dynamic_network_taxis;
plot([t(1) t(end)],[nanmean(dyn1305.focus) nanmean(dyn1305.focus)],'c','LineWidth',2);
t=model020.dynamic_network_taxis;
plot([t(1) t(end)],[nanmean(dyn20.focus) nanmean(dyn20.focus)],'y','LineWidth',2);
axis tight
legend({'6','7','13-2','13-5','20'})
xlabel('Time (s)')
ylabel('Relative strengths')
subplot 122
histogram(dyn1302.focus,'FaceColor','g')
hold on;
histogram(dyn1305.focus,'FaceColor','c')
histogram(dyn20.focus,'FaceColor','y')
histogram(dyn7.focus,'FaceColor','r')
histogram(dyn6.focus,'FaceColor','k')

legend({'13-2','13-5','20','7','6'})
suptitle('Focus to focus: mx0')

%% Plot across: left to right activity

figure;
subplot 121
plot(model006.dynamic_network_taxis,dyn6.across,'k');
hold on;
plot(model007.dynamic_network_taxis,dyn7.across,'r');
plot(model013_rest02.dynamic_network_taxis,dyn1302.across,'g');
plot(model013_rest05.dynamic_network_taxis,dyn1305.across,'c');
plot(model020.dynamic_network_taxis,dyn20.across,'y');

t=model006.dynamic_network_taxis;
plot([t(1) t(end)],[nanmean(dyn6.across) nanmean(dyn6.across)],'k','LineWidth',2);
t=model007.dynamic_network_taxis;
plot([t(1) t(end)],[nanmean(dyn7.across) nanmean(dyn7.across)],'r','LineWidth',2);
t=model013_rest02.dynamic_network_taxis;
plot([t(1) t(end)],[nanmean(dyn1302.across) nanmean(dyn1302.across)],'g','LineWidth',2);
t=model013_rest05.dynamic_network_taxis;
plot([t(1) t(end)],[nanmean(dyn1305.across) nanmean(dyn1305.across)],'c','LineWidth',2);
t=model020.dynamic_network_taxis;
plot([t(1) t(end)],[nanmean(dyn20.across) nanmean(dyn20.across)],'y','LineWidth',2);
axis tight
legend({'6','7','13-2','13-5','20'})
xlabel('Time (s)')
ylabel('Relative strengths')
subplot 122
histogram(dyn1302.focus,'FaceColor','g')
hold on;
histogram(dyn1305.focus,'FaceColor','c')
histogram(dyn20.focus,'FaceColor','y')
histogram(dyn7.focus,'FaceColor','r')
histogram(dyn6.focus,'FaceColor','k')

legend({'13-2','13-5','20','7','6'})
suptitle('Left to right focus: binary')

%% Plot focus_to_global: focus to global\focus activity
figure;
subplot 121
plot(model006.dynamic_network_taxis,dyn6.focus_to_global,'k');
hold on;
plot(model007.dynamic_network_taxis,dyn7.focus_to_global,'r');
plot(model013_rest02.dynamic_network_taxis,dyn1302.focus_to_global,'g');
plot(model013_rest05.dynamic_network_taxis,dyn1305.focus_to_global,'c');
plot(model020.dynamic_network_taxis,dyn20.focus_to_global,'y');

t=model006.dynamic_network_taxis;
plot([t(1) t(end)],[nanmean(dyn6.focus_to_global) nanmean(dyn6.focus_to_global)],'k','LineWidth',2);
t=model007.dynamic_network_taxis;
plot([t(1) t(end)],[nanmean(dyn7.focus_to_global) nanmean(dyn7.focus_to_global)],'r','LineWidth',2);
t=model013_rest02.dynamic_network_taxis;
plot([t(1) t(end)],[nanmean(dyn1302.focus_to_global) nanmean(dyn1302.focus_to_global)],'g','LineWidth',2);
t=model013_rest05.dynamic_network_taxis;
plot([t(1) t(end)],[nanmean(dyn1305.focus_to_global) nanmean(dyn1305.focus_to_global)],'c','LineWidth',2);
t=model020.dynamic_network_taxis;
plot([t(1) t(end)],[nanmean(dyn20.focus_to_global) nanmean(dyn20.focus_to_global)],'y','LineWidth',2);
axis tight
legend({'6','7','13-2','13-5','20'})
xlabel('Time (s)')
ylabel('Relative strengths')

subplot 122
histogram(dyn1302.focus,'FaceColor','g')
hold on;
histogram(dyn1305.focus,'FaceColor','c')
histogram(dyn20.focus,'FaceColor','y')
histogram(dyn7.focus,'FaceColor','r')
histogram(dyn6.focus,'FaceColor','k')

legend({'13-2','13-5','20','7','6'})
suptitle('Focus to global: binary')

%%
avg6 = compute_average_strength( model006,patient_coordinates_006 );
avg7 = compute_average_strength( model007,patient_coordinates_007 );
avg1302 = compute_average_strength( model013_rest02,patient_coordinates_013 );
avg1305 = compute_average_strength( model013_rest05,patient_coordinates_013 );
avg20 = compute_average_strength( model020,patient_coordinates_020 );

figure;
plot(1:1:5,[avg6.kFF avg7.kFF avg1302.kFF avg1305.kFF avg20.kFF],'-*r','LineWidth',2)
hold on
plot(1:1:5,[avg6.kFG avg7.kFG avg1302.kFG avg1305.kFG avg20.kFG],'-*g','LineWidth',2)
plot(1:1:5,[avg6.kLR avg7.kLR avg1302.kLR avg1305.kLR avg20.kLR],'-*k','LineWidth',2)
plot(1:1:5,[avg6.kFT avg7.kFT avg1302.kFT avg1305.kFT avg20.kFT],'-*c','LineWidth',2)
plot(1:1:5,[avg6.kGlobal avg7.kGlobal avg1302.kGlobal avg1305.kGlobal avg20.kGlobal],'-*y','LineWidth',2)
plot(1:1:5,[avg6.kPrPo avg7.kPrPo avg1302.kPrPo avg1305.kPrPo avg20.kPrPo],'-*m','LineWidth',2)
%plot(1:1:5,[avg6.kTT avg7.kTT avg1302.kTT avg1305.kTT avg20.kTT],'-*b','LineWidth',2)

legend('Focus to focus','Focus to global','Left to right','Focus to temporal','global','Pre-Post')
title('Relative Strengths of Averaged Networks: binary')
xticks([1:5]);
xticklabels({'6','7','13-02','13-05','20'})
ylabel('Relative strengths')
%%
load('/Users/erss/Documents/MATLAB/pBECTS006/pBECTS006_sleep07_source.mat');
model006.data = [data_left;data_right];
model006 = remove_artifacts_all_lobes(model006,patient_coordinates_006);
[r,densities ]= compute_dynamic_densities(model006,patient_coordinates_006);

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
%%
[~, iLeft] = sort(densities.left,'descend');
[~, iRight] = sort(densities.right,'descend');
[~, iGlobal] = sort(densities.global,'descend');

range = 1:50;
% [intRight,iRightSpike,ixR] = intersect(iRight(range),net_right);
% [intLeft,iLeftSpike,ixL] = intersect(iLeft(range),net_left);

plot(model007.dynamic_network_taxis(iGlobal(range)),'ko')
hold on;
plot(model007.dynamic_network_taxis(iLeft(range)),'g^')
plot(model007.dynamic_network_taxis(iRight(range)),'rv')
%plot(iRightSpike,model006.dynamic_network_taxis(net_right(ixR)),'r*','MarkerSize',10)
%plot(iLeftSpike,model006.dynamic_network_taxis(net_left(ixL)),'g*','MarkerSize',10)
legend('global','left','right')
ylabel('Time')
xlabel('Index')
title('Indices where max left, right, and global densities occur')
%%

for i=1:10
    k=iGlobal(i)
    t = model006.t;
    window_step = 0.5;
    window_size = 1;
    t_start = t(1) + (k-1) * window_step;   %... get window start time [s],
    t_stop  = t_start + window_size;                  %... get window stop time [s],
    indices = t >= t_start & t < t_stop;
    figure;
    subplot(1,2,1)
    plotchannels(t(indices),data_left(:,indices)');
    title('all left')
    subplot(1,2,2)
    plotchannels(t(indices),data_right(:,indices)');
    title('all right ')
end

[LN, RN] = find_subnetwork_coords(patient_coordinates_013);
k=iRight(13);
t = model013.t;
window_step = 0.5;
window_size = 1;
t_start = t(1) + (k-1) * window_step;   %... get window start time [s],
t_stop  = t_start + window_size;                  %... get window stop time [s],
indices = t >= t_start & t < t_stop;
figure;
subplot(1,2,1)
plotchannels(t(indices),model006.data(LN,indices)');
title('all left')
subplot(1,2,2)
plotchannels(t(indices),model006.data(RN,indices)');
title('all right ')

%
% figure;
% subplot(1,2,1)
% plotchannels(model006.data_clean(LN,indices)');
% title('all left')
% subplot(1,2,2)
% plotchannels(model006.data_clean(RN,indices)');
% title('all right ')

%
taxis_net=model006.dynamic_network_taxis;
% [~,iL] =intersect(taxis_net,net_left);
% [~,iR] =intersect(taxis_net,net_right);
% % plot(model006.dynamic_network_taxis,densities.global);
% % %plot(model006.dynamic_network_taxis(k),densities.global(k),'o');
% % hold on;
% % plot(model006.dynamic_network_taxis(iL),densities.global(iL),'or');
% % plot(model006.dynamic_network_taxis(iR),densities.global(iR),'og');

% Plot densities with spikes
% figure;
% plot(model006.dynamic_network_taxis,densities.global,'k');
% %plot(model006.dynamic_network_taxis(k),densities.global(k),'o');
% hold on;
% plot(model006.dynamic_network_taxis,densities.left,'r');
% plot(model006.dynamic_network_taxis,densities.right,'g');
% plot(model006.dynamic_network_taxis(net_left),densities.left(net_left),'o','MarkerFaceColor','r');
% plot(model006.dynamic_network_taxis(net_right),densities.right(net_right),'o','MarkerFaceColor','g');
% legend('global','left','right');
% xlabel('time (s)')
% ylabel('density')
%%


%%
for ii = 1:25
    k= iLeft(ii);
    t_start = t(1) + (k-1) * window_step;   %... get window start time [s],
    t_stop  = t_start + window_size;                  %... get window stop time [s],
    indices = t >= t_start & t < t_stop;
    f0=2035;
    f_start = 8;%30;
    f_stop  = 95;
    d = model006.data';
    [Sxx, faxis] = pmtm(d(indices,:),4,sum(indices),f0);
    f_indices = faxis >= f_start & faxis < f_stop;
    X =log(faxis(f_indices));
    y = mean(log(Sxx(f_indices,:)),2);
    figure;
    imagesc(log(Sxx(f_indices,:)));
    n = [net_left net_right];
    if sum(k==n) >=1
        title(['spike: ' num2str(ii)])
    else
        title(['no spike: ' num2str(ii)])
    end
end