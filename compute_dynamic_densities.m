function [ r, densities]=compute_dynamic_densities(model,patient_coordinates,specs)
%UNTITLED8 Summary of this function goes here
%   Detailed explanation goes here

% Load t indexed network
if strcmp(specs.A,'raw' )
    if strcmp(specs.measure,'ic' )
        A=abs(model.kIC_beta);
    elseif strcmp(specs.measure,'coherence' )
        A= model.kC;
    elseif strcmp(specs.measure,'xcorr' )
        A=model.mx0;
    else
        A=NaN;
    end
    
    for k=1:size(A,3)
        Atemp = A(:,:,k);
        Atemp = Atemp + transpose(Atemp);
        A(:,:,k) = Atemp;
    end
elseif strcmp(specs.A,'binary' )
    if strcmp(specs.measure,'ic' )
        A = model.net_imag_coh;
    elseif strcmp(specs.measure,'coherence' )
        A = model.net_coh;
    elseif strcmp(specs.measure,'xcorr' )
        A = model.C;
    else
        A=NaN;
    end
else
    A= NaN;
end

n = size(A,1);

% Replace diagnoals with NaNs to ignore self connections
for k=1:size(A,3)
    Atemp = A(:,:,k);
    Atemp(1:1+n:end) = NaN;
    A(:,:,k)=Atemp;
end

taxis = model.dynamic_network_taxis;

% Determine subnetwork indices
[ LN,RN ] = find_subnetwork_coords( patient_coordinates);

% Define subnetworks of interest
network_left_focus    = A(LN,LN,:);
network_right_focus   = A(RN,RN,:);
network_left_to_right = A(LN,RN,:);

fc_left_focus   = zeros(1,size(A,3));
fc_right_focus  = zeros(1,size(A,3));
fc_global = zeros(1,size(A,3));
fc_left_to_right = zeros(1,size(A,3));

for i = 1:size(A,3)
    
    % Grab each network at each point in time
    nL  = network_left_focus(:,:,i);    % grab each network at each point in time
    nR  = network_right_focus(:,:,i);
    nG  = A(:,:,i);
    nA  = network_left_to_right(:,:,i);
    
    % Compute and store density at that index
    fc_left_focus(i)    = nanmean(nL(:)); % compute and store mean connectivity for
    fc_right_focus(i)   = nanmean(nR(:));  % ... each network
    fc_global(i)        = nanmean(nG(:));
    fc_left_to_right(i) = nanmean(nA(:));
    
end


densities.left = fc_left_focus;
densities.right = fc_right_focus;
densities.global = fc_global;
densities.across = fc_left_to_right;

%%% Plot histograms of densities
figure;
subplot 122
histogram(fc_left_focus,'FaceColor','r')
hold on;
histogram(fc_right_focus,'FaceColor','g')
histogram(fc_global,'FaceColor','k')
histogram(fc_left_to_right,'FaceColor','c')
box off
set(gca,'FontSize',18)
title('Histogram','FontSize',20)
ylabel('Counts','FontSize',20)
xlabel('Mean Coherence Values','FontSize',20)
axis square
%%% plot connectivity over time

subplot 121
plot(taxis,fc_left_focus,'r','LineWidth',1.5);
hold on
plot(taxis,fc_right_focus,'g','LineWidth',1.5)
plot(taxis,fc_left_to_right,'c','LineWidth',1.5)
plot(taxis,fc_global,'k','LineWidth',1.5)

%title(['Density of: ' specs.A],'FontSize',16)
set(gca,'FontSize',18)
title('Mean Coherence Values vs Time','FontSize',20)
axis tight
xlabel('Time (s)','FontSize',20)
ylabel('Mean Coherence','FontSize',20)
axis square
box off
hold on
plot([taxis(1),taxis(1)+20], [0.2, 0.2], 'k', 'LineWidth', 2.5);
set(gca,'XTickLabel',[]);
set(gca,'XTick',[]);
% compute + plot mean connectivity
v1=fc_left_focus-nanmean(fc_left_focus);
v2=fc_right_focus-nanmean(fc_right_focus);
v1(isnan(v1))=[];
v2(isnan(v2))=[];
r= xcorr(v1,v2,0,'coeff');

[mn, bds ]=normal_stats(fc_left_focus);
plot([taxis(1) taxis(end)],[mn mn],'-r','LineWidth',1.3)
plot([taxis(1) taxis(end)],[bds(1) bds(1)],'--r')
plot([taxis(1) taxis(end)],[bds(2) bds(2)],'--r')

[mn1, bds ]=normal_stats(fc_right_focus);
plot([taxis(1) taxis(end)],[mn1 mn1],'-g','LineWidth',1.3)
plot([taxis(1) taxis(end)],[bds(1) bds(1)],'--g')
plot([taxis(1) taxis(end)],[bds(2) bds(2)],'--g')

[mn2, bds ]=normal_stats(fc_global);
plot([taxis(1) taxis(end)],[mn2 mn2],'-k','LineWidth',1.3)
plot([taxis(1) taxis(end)],[bds(1) bds(1)],'--k')
plot([taxis(1) taxis(end)],[bds(2) bds(2)],'--k')
[mn2, bds ]=normal_stats(fc_left_to_right);

plot([taxis(1) taxis(end)],[mn2 mn2],'-c','LineWidth',1.3)
plot([taxis(1) taxis(end)],[bds(1) bds(1)],'--c')
plot([taxis(1) taxis(end)],[bds(2) bds(2)],'--c')


h=legend({'Left SOZ','Right SOZ','Left to Right','Global'},'FontSize',16);
legend boxoff
%%% Print results
fprintf(['left nodes:    ' num2str(size(network_left_focus,1)) '\n'])
fprintf(['right nodes:   ' num2str(size(network_right_focus,1)) '\n'])
fprintf(['left density:  ' num2str(mn) '\n'])
fprintf(['right density: ' num2str(mn1) '\n'])
fprintf(['correlation: ' num2str(r) '\n'])

end

