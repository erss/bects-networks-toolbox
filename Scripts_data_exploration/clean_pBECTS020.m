%%% script to find bad channels for patient 20 - rest 03
load('/Users/erss/Documents/MATLAB/pBECTS_inferred_nets/coherence - r1/pBECTS020_coherence.mat')
isfinite(model.t_clean);
data = [data_left;data_right];
%%
badchannels=[];
for i = 0:15
    win = i*20+1:i*20+20;
    figure;
    plotchannels(data(win,:)')
%     if i == 0
%         badchannels = win([1 2 3 9 10 11 15 19]);
%     elseif i == 1
%         badchannels = [badchannels win(14)]
%     elseif i == 2
%         badchannels = [badchannels win([1 4 8])]
%     elseif i == 8
%         badchannels = [badchannels win([3 4 6 10 13 14 15 16 17 20])]
%     elseif i == 9
%         badchannels = [badchannels win(15)]
%     end
    
end
%%
figure;
plotchannels(data(304:end,end-2035:end)')

%%
figure;
plotchannels(data(badchannels,end-2035:end)')

%%
load('/Users/erss/Documents/MATLAB/pBECTS020/patient_coordinates_020.mat')
[ LN,RN ] = find_subnetwork_coords( patient_coordinates_020);


plotchannels(data([LN;RN],end-2035:end)')


for i = [LN;RN]'
    figure;
    plot(data(i,end-2035:end))
    title(num2str(i))
end

%%

[ LNp,RNp] = find_subnetwork_lobe( patient_coordinates_020,'parietal');
[ LNt,RNt] = find_subnetwork_lobe( patient_coordinates_020,'temporal');
[ LNo,RNo] = find_subnetwork_lobe( patient_coordinates_020,'occipital');
[ LNf,RNf] = find_subnetwork_lobe( patient_coordinates_020,'frontal');

badchannels = [1 2 3 9 10 11 15 19 34 41 44 48 163 164 166 170 173 ...
    174 175 176 177 180 195];
data(badchannels,:) = NaN(length(badchannels),size(data,2));

%%% patietal & occipital lobe
plotchannels(data([ LNo;RNo],end-2035:end)');