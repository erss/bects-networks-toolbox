function [rel_fc]=compute_focus_connectivities(model,patient_coordinates)
% Computes how relatively dense activity is from the seizure focus to the
% the rest of the network to how
% dense the overall network is.  
A = model.C;
taxis = model.dynamic_network_taxis;
[LN,RN] = find_subnetwork_coords( patient_coordinates);
n = size(A,2);
for k=1:size(A,3)
    Atemp = A(:,:,k);
    Atemp(1:1+n:end) = NaN;
    A(:,:,k)=Atemp;
end

GN = setdiff(1:n,[LN,RN]); % returns indices of nodes not in network
A1 = A([LN RN],GN,:);
fc   = zeros(1,size(A1,3));
fc_g = zeros(1,size(A1,3));
for i = 1:size(A1,3)
    f  = A1(:,:,i);    % grab each network at each point in time
    fc(i) = nanmean(f(:)); %nansum(f(:))/(n1);  % compute and store mean connectivity for
                                    % ... each network
                                    
   g = A(:,:,i);
   fc_g(i) =nanmean(g(:)); %nansum(g(:))/(n^2 - n);
end
rel_fc = fc./fc_g;
% plot(taxis,fc,'r');
% title('Density','FontSize',16)
% ylim([0 max(fc)])
% box off
% hold on
% % compute + plot mean connectivity
% [mn, bds ]=normal_stats(fc);
% 
% plot([taxis(1) taxis(end)],[mn mn],'-r')
% plot([taxis(1) taxis(end)],[bds(1) bds(1)],'--r')
% plot([taxis(1) taxis(end)],[bds(2) bds(2)],'--r')
%plot(model.taxis(left_events),fc(left_events),'or')

end

