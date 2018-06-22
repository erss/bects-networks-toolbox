function compute_network_centralities( A,patient_coordinates)
%UNTITLED10 Summary of this function goes here
%   Detailed explanation goes here
[ LN,RN] = subnetworks( patient_coordinates);
 
Aleft = A;
Aright = A;

Aleft(LN,LN,:) =nan;
Aright(RN,RN,:) = nan;

Aleft(LN,:,:) = [];
Aright(RN,:,:) = [];

% Aleft(:,163:end,:) = [];
% Aright(:,1:162,:) = [];

%xyz =patient_coordinates.coords(3:end,:);

for i = 1:size(Aleft,3)
    f  = Aleft(:,:,i);    % grab each network at each point in time
    c  = Aright(:,:,i);
   
    dc_left(i)   = sum(f(:));  % compute and store mean connectivity for
    dc_right(i)  = sum(c(:));  % ... each network
end

model.taxis = 1:length(dc_left); %model.taxis%1:length(fc_left);
% plot connectivity over time
figure;
plot(model.taxis,dc_left,'r');
hold on
plot(model.taxis,dc_right,'g')
title('Centrality','FontSize',16)
box off

end

