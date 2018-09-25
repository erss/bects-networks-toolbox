patient_coordinates_006.status='active-left';
patient_coordinates_007.status='active-right';
patient_coordinates_013.status='healthy';
specs.normalize = 'false'; % true or false
specs.A = 'binary'; % raw or binary

avg6 = compute_average_strength( model006,patient_coordinates_006,specs );
avg7 = compute_average_strength( model007,patient_coordinates_007,specs );
avg1302 = compute_average_strength( model013,patient_coordinates_013,specs );

avg1305.kGlobal= 0;
avg1305.kFF= 0;
avg1305.kFG= 0;
avg1305.kLR= 0;
avg1305.kFT= 0;
avg1305.kPrPo= 0;

avg20.kGlobal= 0;
avg20.kFF= 0;
avg20.kFG= 0;
avg20.kLR= 0;
avg20.kFT= 0;
avg20.kPrPo= 0;
%avg1305 = compute_average_strength( model013_rest05,patient_coordinates_013,specs );
%avg20 = compute_average_strength( model020,patient_coordinates_020,specs );
%%
figure;
subplot 611
plot(1:1:5,[avg6.kFF avg7.kFF avg1302.kFF avg1305.kFF avg20.kFF],'-*r','LineWidth',2)
xticks([1:5]);
xticklabels({'6','7','13-02','13-05','20'})
title('Focus to focus')

subplot 612
plot(1:1:5,[avg6.kFG avg7.kFG avg1302.kFG avg1305.kFG avg20.kFG],'-*g','LineWidth',2)
xticks([1:5]);
xticklabels({'6','7','13-02','13-05','20'})
title('Focus to global')

subplot 613
plot(1:1:5,[avg6.kLR avg7.kLR avg1302.kLR avg1305.kLR avg20.kLR],'-*k','LineWidth',2)
xticks([1:5]);
xticklabels({'6','7','13-02','13-05','20'})
title('Left to right')

if strcmp(specs.normalize, 'true')
    ylabel('Relative strengths','FontSize',20)
else
    ylabel('Absolute strengths','FontSize',20)
end

subplot 614
plot(1:1:5,[avg6.kFT avg7.kFT avg1302.kFT avg1305.kFT avg20.kFT],'-*c','LineWidth',2)
xticks([1:5]);
xticklabels({'6','7','13-02','13-05','20'})
title('Focus to temporal')

subplot 615
plot(1:1:5,[avg6.kGlobal avg7.kGlobal avg1302.kGlobal avg1305.kGlobal avg20.kGlobal],'-*b','LineWidth',2)
xticks([1:5]);
xticklabels({'6','7','13-02','13-05','20'})
title('Global')

subplot 616
plot(1:1:5,[avg6.kPrPo avg7.kPrPo avg1302.kPrPo avg1305.kPrPo avg20.kPrPo],'-*m','LineWidth',2)
xticks([1:5]);
xticklabels({'6','7','13-02','13-05','20'})
title('Pre to Post central')

%legend('Focus to focus','Focus to global','Left to right','Focus to temporal','global','Pre-Post')
suptitle(['Averaged networks: ' specs.A  ])

