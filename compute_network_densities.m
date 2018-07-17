function [ r, densities]=compute_network_densities(A,patient_coordinates)
%UNTITLED8 Summary of this function goes here
%   Detailed explanation goes here

[ LN,RN ] = subnetworks( patient_coordinates);
Aleft = A(LN,LN,:);
Aright = A(RN,RN,:);
Across = A(LN,RN,:);

fc_left   = zeros(1,size(Aleft,3));
fc_right  = zeros(1,size(Aleft,3));
fc_global = zeros(1,size(Aleft,3));
fc_across = zeros(1,size(Aleft,3));

for i = 1:size(Aleft,3)
    
    f  = Aleft(:,:,i);    % grab each network at each point in time
    c  = Aright(:,:,i);
    g  = A(:,:,i);
    a = Across(:,:,i);
    fc_left(i)   = mean(f(:));  % compute and store mean connectivity for
    fc_right(i)  = mean(c(:));  % ... each network
    fc_global(i) = mean(g(:));
    fc_across(i) = mean(a(:));
end
model.taxis = 1:length(fc_left); %model.taxis%1:length(fc_left);

densities.left = fc_left;
densities.right = fc_right;
densities.global = fc_global;
densities.across = fc_across;
%%% plot histograms of densities
figure;
histogram(fc_left,'FaceColor','r')
hold on;
histogram(fc_right,'FaceColor','g')
histogram(fc_global,'FaceColor','k')
histogram(fc_across,'FaceColor','c')
%legend('global','left','right')
legend({'Left','Right','Global','Across'},'FontSize',14);
%%% plot connectivity over time
figure;
plot(model.taxis,fc_left,'r');
hold on
plot(model.taxis,fc_right,'g')
plot(model.taxis,fc_across,'c')
plot(model.taxis,fc_global,'k')
title('Density','FontSize',16)
ylim([0 1])
box off

% compute + plot mean connectivity

[r]= xcorr(fc_left-mean(fc_left),fc_right-mean(fc_right),0,'coeff');
title(num2str(r))
[mn, bds ]=normal_stats(fc_left);

plot([model.taxis(1) model.taxis(end)],[mn mn],'-r')
plot([model.taxis(1) model.taxis(end)],[bds(1) bds(1)],'--r')
plot([model.taxis(1) model.taxis(end)],[bds(2) bds(2)],'--r')

[mn1, bds ]=normal_stats(fc_right);
plot([model.taxis(1) model.taxis(end)],[mn1 mn1],'-g')
plot([model.taxis(1) model.taxis(end)],[bds(1) bds(1)],'--g')
plot([model.taxis(1) model.taxis(end)],[bds(2) bds(2)],'--g')
[mn2, bds ]=normal_stats(fc_global);
plot([model.taxis(1) model.taxis(end)],[mn2 mn2],'-k')
plot([model.taxis(1) model.taxis(end)],[bds(1) bds(1)],'--k')
plot([model.taxis(1) model.taxis(end)],[bds(2) bds(2)],'--k')
h=legend({'Left','Right','Across','Global'},'FontSize',14);
xlabel(['Time (s)'],'FontSize',15)
% Save and print results

fprintf(['left nodes:    ' num2str(size(Aleft,1)) '\n'])
fprintf(['right nodes:   ' num2str(size(Aright,1)) '\n'])
fprintf(['left density:  ' num2str(mn) '\n'])
fprintf(['right density: ' num2str(mn1) '\n'])
% fprintf(['global density:' num2str(mn2) '\n'])


%[r, lag]= xcorr(fc_left-mean(fc_left),fc_right-mean(fc_right),'coeff');

end

