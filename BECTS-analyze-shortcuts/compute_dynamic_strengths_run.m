%%% compute_dynamic_densities scripts + plots
specs.normalize = 'true'; % true or false
specs.A = 'raw'; % raw or binary
specs.measure ='coherence';
%%
dyn6    = compute_dynamic_strength(model006,patient_coordinates_006,specs);
dyn7    = compute_dynamic_strength(model007,patient_coordinates_007,specs);
dyn1302 = compute_dynamic_strength(model013,patient_coordinates_013,specs);
% dyn1305 = compute_dynamic_strength(model013_rest05,patient_coordinates_013,specs);
dyn20   = compute_dynamic_strength(model020,patient_coordinates_020,specs);

%% Plot focus to focus activity

figure;
subplot 121
plot(model006.dynamic_network_taxis,dyn6.focus,'k');
hold on;
plot(model007.dynamic_network_taxis,dyn7.focus,'r');
plot(model013_rest02.dynamic_network_taxis,dyn1302.focus,'g');
% plot(model013_rest05.dynamic_network_taxis,dyn1305.focus,'c');
plot(model020.dynamic_network_taxis,dyn20.focus,'y');

t=model006.dynamic_network_taxis;
plot([t(1) t(end)],[nanmean(dyn6.focus) nanmean(dyn6.focus)],'k','LineWidth',2);
t=model007.dynamic_network_taxis;
plot([t(1) t(end)],[nanmean(dyn7.focus) nanmean(dyn7.focus)],'r','LineWidth',2);
t=model013_rest02.dynamic_network_taxis;
plot([t(1) t(end)],[nanmean(dyn1302.focus) nanmean(dyn1302.focus)],'g','LineWidth',2);
% t=model013_rest05.dynamic_network_taxis;
% plot([t(1) t(end)],[nanmean(dyn1305.focus) nanmean(dyn1305.focus)],'c','LineWidth',2);
 t=model020.dynamic_network_taxis;
 plot([t(1) t(end)],[nanmean(dyn20.focus) nanmean(dyn20.focus)],'y','LineWidth',2);
axis tight
%legend({'6','7','13-2','13-5','20'})
legend({'6','7','13-2','20'})

xlabel('Time (s)')

if strcmp(specs.normalize, 'true')
    ylabel('Relative strengths')
else
    ylabel('Absolute strengths')
end


subplot 122
histogram(dyn1302.focus,'FaceColor','g')
hold on;
% histogram(dyn1305.focus,'FaceColor','c')
histogram(dyn20.focus,'FaceColor','y')
histogram(dyn7.focus,'FaceColor','r')
histogram(dyn6.focus,'FaceColor','k')

%legend({'13-2','13-5','20','7','6'})
legend({'13','20','7','6'})
suptitle(['Focus to focus: ' specs.A  ])

%% Plot across: left to right activity

figure;
subplot 121
plot(model006.dynamic_network_taxis,dyn6.across,'k');
hold on;
plot(model007.dynamic_network_taxis,dyn7.across,'r');
plot(model013_rest02.dynamic_network_taxis,dyn1302.across,'g');
% plot(model013_rest05.dynamic_network_taxis,dyn1305.across,'c');
 plot(model020.dynamic_network_taxis,dyn20.across,'y');

t=model006.dynamic_network_taxis;
plot([t(1) t(end)],[nanmean(dyn6.across) nanmean(dyn6.across)],'k','LineWidth',2);
t=model007.dynamic_network_taxis;
plot([t(1) t(end)],[nanmean(dyn7.across) nanmean(dyn7.across)],'r','LineWidth',2);
t=model013_rest02.dynamic_network_taxis;
plot([t(1) t(end)],[nanmean(dyn1302.across) nanmean(dyn1302.across)],'g','LineWidth',2);
% t=model013_rest05.dynamic_network_taxis;
% plot([t(1) t(end)],[nanmean(dyn1305.across) nanmean(dyn1305.across)],'c','LineWidth',2);
 t=model020.dynamic_network_taxis;
 plot([t(1) t(end)],[nanmean(dyn20.across) nanmean(dyn20.across)],'y','LineWidth',2);
axis tight
%legend({'6','7','13-2','13-5','20'})
legend({'6','7','13-2','20'})
xlabel('Time (s)')

if strcmp(specs.normalize, 'true')
    ylabel('Relative strengths')
else
    ylabel('Absolute strengths')
end
subplot 122
histogram(dyn1302.across,'FaceColor','g')
hold on;
% histogram(dyn1305.across,'FaceColor','c')
 histogram(dyn20.across,'FaceColor','y')
histogram(dyn7.across,'FaceColor','r')
histogram(dyn6.across,'FaceColor','k')

%legend({'13-2','13-5','20','7','6'})
legend({'13','20','7','6'})
suptitle(['Left to right focus ' specs.A  ])

%% Plot focus_to_global: focus to global\focus activity
figure;
subplot 121
plot(model006.dynamic_network_taxis,dyn6.focus_to_global,'k');
hold on;
plot(model007.dynamic_network_taxis,dyn7.focus_to_global,'r');
plot(model013_rest02.dynamic_network_taxis,dyn1302.focus_to_global,'g');
% plot(model013_rest05.dynamic_network_taxis,dyn1305.focus_to_global,'c');
 plot(model020.dynamic_network_taxis,dyn20.focus_to_global,'y');

t=model006.dynamic_network_taxis;
plot([t(1) t(end)],[nanmean(dyn6.focus_to_global) nanmean(dyn6.focus_to_global)],'k','LineWidth',2);
t=model007.dynamic_network_taxis;
plot([t(1) t(end)],[nanmean(dyn7.focus_to_global) nanmean(dyn7.focus_to_global)],'r','LineWidth',2);
t=model013_rest02.dynamic_network_taxis;
plot([t(1) t(end)],[nanmean(dyn1302.focus_to_global) nanmean(dyn1302.focus_to_global)],'g','LineWidth',2);
% t=model013_rest05.dynamic_network_taxis;
% plot([t(1) t(end)],[nanmean(dyn1305.focus_to_global) nanmean(dyn1305.focus_to_global)],'c','LineWidth',2);
 t=model020.dynamic_network_taxis;
 plot([t(1) t(end)],[nanmean(dyn20.focus_to_global) nanmean(dyn20.focus_to_global)],'y','LineWidth',2);
axis tight
%legend({'6','7','13-2','13-5','20'})
legend({'6','7','13-2','20'})
xlabel('Time (s)')

if strcmp(specs.normalize, 'true')
    ylabel('Relative strengths')
else
    ylabel('Absolute strengths')
end

subplot 122
histogram(dyn1302.focus_to_global,'FaceColor','g')
hold on;
% histogram(dyn1305.focus_to_global,'FaceColor','c')
 histogram(dyn20.focus_to_global,'FaceColor','y')
histogram(dyn7.focus_to_global,'FaceColor','r')
histogram(dyn6.focus_to_global,'FaceColor','k')
legend({'13','20','7','6'})
%legend({'13-2','13-5','20','7','6'})
suptitle(['Focus to global: ' specs.A  ])