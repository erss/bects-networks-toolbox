function compute_network_densities_by_distance(A,patient_coordinates)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

[ LN,RN ] = subnetworks( patient_coordinates);
xyz = patient_coordinates.coords;
center_LN = mean(xyz(3:5,LN),2);
center_LN = repmat(center_LN,[1,324]);

center_RN = mean(xyz(3:5,RN),2);
center_RN = repmat(center_RN,[1,324]);

distances_from_left_center = (xyz(3:5,:) - center_LN).^2;
distances_from_left_center = sqrt(sum(distances_from_left_center,1));
[~, iL] = sort(distances_from_left_center,'ascend');


distances_from_right_center = (xyz(3:5,:) - center_RN).^2;
distances_from_right_center = sqrt(sum(distances_from_right_center,1));
[~, iR] = sort(distances_from_right_center,'ascend');

daxis = 10:300;

for k = 1:length(daxis)
    ix = iL(1:daxis(k));
    Atemp = A(ix,ix,:); 
    Atemp = reshape(Atemp,[length(ix)^2 size(Atemp,3)]);
    dL(k) = mean(mean(Atemp,2));
    
    ix = iR(1:daxis(k));
    Atemp = A(ix,ix,:); 
    Atemp = reshape(Atemp,[length(ix)^2 size(Atemp,3)]);
    dR(k) = mean(mean(Atemp,2));
    fprintf([num2str(k) '\n'])
end
figure;
plot(daxis,dL,'r')
hold on
plot(daxis,dR,'g')
legend('left','right')

end

