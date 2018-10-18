function plot_adj_matrix( A )
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here

% Network movie
%OUTVIDPATH = strcat('~/Desktop/',patient,'.avi');
OUTVIDPATH = '/Users/erss/Documents/MATLAB/BECTS-networks';


v = VideoWriter(OUTVIDPATH);
v.FrameRate=15;
open(v);
h = figure;

for j = 1:size(A,3)
    
    plotNetwork(A(:,:,j))
    
    hold off
    drawnow
    
    F = getframe(h);
    image = F.cdata;
    writeVideo(v,image(1:end,1:end,:));
end
close(v)

end

