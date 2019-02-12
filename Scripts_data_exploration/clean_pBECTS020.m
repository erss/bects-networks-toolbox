%%% script to find bad channels for patient 20 - rest 03
load('/Users/erss/Documents/MATLAB/pBECTS_results/coherence - r4/pBECTS013_rest02_sigma_two_seconds.mat')
load('/Users/erss/Documents/MATLAB/pBECTS013/sleep_source/pBECTS013_rest02_source.mat')
load('/Users/erss/Documents/MATLAB/pBECTS013/patient_coordinates_013.mat')

model = model_sigma_two;
pc=patient_coordinates_013;
isfinite(model.t_clean);
model.data = [data_left;data_right];
%%
indices = model.t < 3 & model.t >=2.5;
badchannels=[];
for i = 0:15
    win = i*20+1:i*20+20;
    figure;
    plotchannels(data(win,indices)')
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
[ LN,RN ] = find_subnetwork_coords( pc);


plotchannels(data([LN;RN],end-2035:end)')


for i = [LN;RN]'
    figure;
    plot(data(i,end-2035:end))
    title(num2str(i))
end

%%

[ LNp,RNp] = find_subnetwork_lobe( pc,'parietal');
[ LNt,RNt] = find_subnetwork_lobe( pc,'temporal');
[ LNo,RNo] = find_subnetwork_lobe( pc,'occipital');
[ LNf,RNf] = find_subnetwork_lobe( pc,'frontal');

badchannels = [1 2 3 9 10 11 15 19 34 41 44 48 163 164 166 170 173 ...
    174 175 176 177 180 195];
data(badchannels,:) = NaN(length(badchannels),size(data,2));

%%% patietal & occipital lobe
plotchannels(data([ LNo;RNo],end-2035:end)');

%%

badchannels = [14 15 16 17 18 20 24 25 29 31 32 35 36 41 42 44 47 48 53 54 57 ...
    64 69 71 72 74 88 104 130 132];

dtest=data(badchannels,indices)';
plotchannels(dtest)

%%
indices = model.t < 10.5 & model.t >=10;
model.bad_channels =[1:8 10 12 14 15 16 17 18 20 21 24 25 29 31 32 35 36 39 41 ...
    42 44 47 48 53 54 57 64 69 71 72 74 88 104 130 132 163 165:167 170 ...
   172 177 180 182 183 193 201 206 212 230 233];
[ data2 ] = remove_bad_channels( model );
[Lo,Ro]=find_subnetwork_lobe(patient_coordinates_013,'occipital');
plotchannels(model.data([Lo; Ro],indices)')
figure;
plotchannels(data2([Lo; Ro],indices)')