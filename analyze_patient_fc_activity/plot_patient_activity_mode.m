function r = plot_patient_activity_mode( model,pc )
% PLOT_PATIENT_ACTIVITY plots density traces of spiking SOZ, nonspiking
% SOZ, global, and between L and R SOZ.

taxis = model.dynamic_network_taxis;
% Determine subnetwork indices
[ LN,RN ] = find_subnetwork_coords(pc);
n = size(model.kC,1); % all nodes in the network
% Define subnetworks of interest
if strcmp(pc.status,'active-left') || strcmp(pc.status,'healthy') ... 
        ||   strcmp(pc.status,'remission')
    spikingSOZ    = LN;
    nonspikingSOZ = RN;
elseif strcmp(pc.status,'active-right')
    spikingSOZ    = RN;
    nonspikingSOZ = LN;
end

nodes.source = LN;
nodes.target = RN;

dSpiking    = compute_patient_activity( model,pc,spikingSOZ);
dNonSpiking = compute_patient_activity( model,pc,nonspikingSOZ);
dAcross     = compute_patient_activity( model,pc,nodes);

dGlobal     = compute_patient_activity( model,pc,1:n);

[kSpiking, bSpiking ] = compute_mode( model, pc, spikingSOZ);
[kNonSpiking, bNonSpiking ] = compute_mode( model, pc,nonspikingSOZ);
[kAcross, bAcross] = compute_mode( model, pc,nodes);
%[kGlobal, bGlobal] = compute_mode( model, pc,1:n);



figure; hold on;

% Plot densities over time
plot(taxis,dSpiking,'r','LineWidth',1.5);
plot(taxis,dNonSpiking,'g','LineWidth',1.5)
plot(taxis,dAcross,'c','LineWidth',1.5)
plot(taxis,dGlobal,'k','LineWidth',1.5)

xlabel('Time (s)','FontSize',20)
ylabel('Mean Coherence','FontSize',20)
axis square
box off
plot([taxis(1),taxis(1)+20], [0.2, 0.2], 'k', 'LineWidth', 2.5);
set(gca,'XTickLabel',[]);
set(gca,'XTick',[]);
% Compute correlation between spiking and nonspiking SOZ
v1 = dSpiking-nanmean(dSpiking);
v2 = dNonSpiking-nanmean(dNonSpiking);
v1(isnan(v1))=[];
v2(isnan(v2))=[];
r= xcorr(v1,v2,0,'coeff');
title([model.patient_name '- ' model.fband ' -xcorr: ' num2str(r)],'FontSize',20)

% Plot error bars
plot([taxis(1) taxis(end)],[kSpiking kSpiking],'-r','LineWidth',1.3)
plot([taxis(1) taxis(end)],[bSpiking(1) bSpiking(1)],'--r')
plot([taxis(1) taxis(end)],[bSpiking(2) bSpiking(2)],'--r')

plot([taxis(1) taxis(end)],[kNonSpiking kNonSpiking],'-g','LineWidth',1.3)
plot([taxis(1) taxis(end)],[bNonSpiking(1) bNonSpiking(1)],'--g')
plot([taxis(1) taxis(end)],[bNonSpiking(2) bNonSpiking(2)],'--g')

plot([taxis(1) taxis(end)],[kAcross kAcross],'-c','LineWidth',1.3)
plot([taxis(1) taxis(end)],[bAcross(1) bAcross(1)],'--c')
plot([taxis(1) taxis(end)],[bAcross(2) bAcross(2)],'--c')

% plot([taxis(1) taxis(end)],[kGlobal kGlobal],'-k','LineWidth',1.3)
% plot([taxis(1) taxis(end)],[bGlobal(1) bGlobal(1)],'--k')
% plot([taxis(1) taxis(end)],[bGlobal(2) bGlobal(2)],'--k')
axis tight
ylim([0 1])
if strcmp(pc.status,'healthy') || strcmp(pc.status,'remission')
    h=legend({'Left Lower Pre/Post CG','Right Lower Pre/Post CG','Between L-R','Global'},'FontSize',16);
else
    h=legend({'Spiking SOZ','Non  Spiking SOZ','Between SOZs','Global'},'FontSize',16);
end
legend boxoff
set(gca,'FontSize',18)


end

