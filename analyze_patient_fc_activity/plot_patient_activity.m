function r = plot_patient_activity( model,pc )
% PLOT_PATIENT_ACTIVITY plots density traces of spiking SOZ, nonspiking
% SOZ, global, and between L and R SOZ.

taxis = model.dynamic_network_taxis;
% Determine subnetwork indices
[ LN,RN ] = find_subnetwork_coords(pc);
n = size(model.kC,1); % all nodes in the network
% Define subnetworks of interest
if strcmp(pc.status,'active-left') || strcmp(pc.status,'healthy')
    spikingSOZ    = LN;
    nonspikingSOZ = RN;
elseif strcmp(pc.status,'active-right')
    spikingSOZ    = RN;
    nonspikingSOZ = LN;
end

nodes.source = LN;
nodes.target = RN;

[dSpiking,mnSpiking,~,semSpiking] = compute_patient_activity( model,pc,spikingSOZ);
[dNonSpiking,mnNonSpiking,~,semNonSpiking] = compute_patient_activity( model,pc,nonspikingSOZ);
[dAcross,mnAcross,~,semAcross] = compute_patient_activity( model,pc,nodes);
[dGlobal,mnGlobal,~,semGlobal] = compute_patient_activity( model,pc,1:n);

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
title([model.patient_name '-' num2str(model.window_size) 's-xcorr: ' num2str(r)],'FontSize',20)

% Plot error bars
plot([taxis(1) taxis(end)],[mnSpiking mnSpiking],'-r','LineWidth',1.3)
plot([taxis(1) taxis(end)],[mnSpiking-1.96*semSpiking mnSpiking-1.96*semSpiking],'--r')
plot([taxis(1) taxis(end)],[mnSpiking+1.96*semSpiking mnSpiking+1.96*semSpiking],'--r')

plot([taxis(1) taxis(end)],[mnNonSpiking mnNonSpiking],'-g','LineWidth',1.3)
plot([taxis(1) taxis(end)],[mnNonSpiking-1.96*semNonSpiking mnNonSpiking-1.96*semNonSpiking],'--g')
plot([taxis(1) taxis(end)],[mnNonSpiking+1.96*semNonSpiking mnNonSpiking+1.96*semNonSpiking],'--g')

plot([taxis(1) taxis(end)],[mnAcross mnAcross],'-c','LineWidth',1.3)
plot([taxis(1) taxis(end)],[mnAcross-1.96*semAcross mnAcross-1.96*semAcross],'--c')
plot([taxis(1) taxis(end)],[mnAcross+1.96*semAcross mnAcross+1.96*semAcross],'--c')

plot([taxis(1) taxis(end)],[mnGlobal mnGlobal],'-k','LineWidth',1.3)
plot([taxis(1) taxis(end)],[mnGlobal-1.96*semGlobal mnGlobal-1.96*semGlobal],'--k')
plot([taxis(1) taxis(end)],[mnGlobal+1.96*semGlobal mnGlobal+1.96*semGlobal],'--k')
axis tight
ylim([0 1])
if strcmp(pc.status,'healthy')
    h=legend({'Left Lower Pre/Post CG','Right Lower Pre/Post CG','Between L-R','Global'},'FontSize',16);
else
    h=legend({'Spiking SOZ','Non  Spiking SOZ','Between SOZs','Global'},'FontSize',16);
end
legend boxoff
set(gca,'FontSize',18)


end

