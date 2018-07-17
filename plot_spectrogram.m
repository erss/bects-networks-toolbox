function plot_spectrogram( model,pc,k)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
data = model.data_mn;
f0 = 2035;
[LN,RN] = subnetworks( pc);
%d = data([LN, RN],:)';
d = data';
%%
t = model.t;
window_step = 0.5;
window_size = 1;

t_start = t(1) + (k-1) * window_step;   %... get window start time [s],
t_stop  = t_start + window_size;                  %... get window stop time [s],
indices = t >= t_start & t < t_stop;
d = data([LN, RN],:)';
[Sxx, faxis] = pmtm(d(indices,:),4,sum(indices),f0);
imagesc(log(Sxx));
ylim([0 30])

figure;
S= log(Sxx);
hold on
plot(faxis,mean(Sxx,2) )

%%
figure;
subplot(2,1,1)
plotchannels(d(indices,LN));
title('left')
subplot(2,1,2)
plotchannels(d(indices,RN));
title('right')
end

