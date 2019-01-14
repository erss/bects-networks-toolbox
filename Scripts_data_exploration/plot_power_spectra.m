%%% plot 5-30 Hz power spectra for BECTS vs HC in SOZ 
%%% (separate BECTS spiking focus, non spiking focus and combined 
%%% (spiking + non spiking) as separate lines). 
%%% Confirm lack of bump in 10-15 Hz in A-BECTS that is present in R-BECTS.

psd_003 = power_in_focus( model003,patient_coordinates_003);
psd_006 = power_in_focus( model006,patient_coordinates_006);
psd_007 = power_in_focus( model007,patient_coordinates_007);

psd_013 = power_in_focus( model013,patient_coordinates_013);
psd_019 = power_in_focus( model019,patient_coordinates_019);
psd_020 = power_in_focus( model020,patient_coordinates_020);

hc_spectra = psd_013.power_combined + psd_019.power_combined + psd_020.power_combined ;
aBECTS_spiking_focus = psd_003.power_left + psd_006.power_left+ psd_007.power_right ;
aBECTS_nonspiking_focus = psd_003.power_right + psd_006.power_right+ psd_007.power_left ;
aBECTS_combined  = psd_003.power_combined + psd_006.power_combined + psd_007.power_combined ;
f=model003.f;
%%
plot(f,hc_spectra./3,f,aBECTS_spiking_focus./3,f,aBECTS_nonspiking_focus./3,f,aBECTS_combined./3)
xlim([5 30])
xlabel('Frequency')
ylabel('Mean power')
legend('Healthy controls','BECTS spiking', 'BECTS non spiking', 'BECTS combined')
figure;
plot(f,psd_013.power_combined,'k','LineWidth',1.5)
hold on
plot(f, psd_019.power_combined,'--k','LineWidth',1.5)
plot(f,psd_020.power_combined ,'-.k','LineWidth',1.5)

plot(f,psd_003.power_left,'m',f, psd_006.power_left,'--m',f,psd_007.power_right ,'om')
plot(f,psd_003.power_right,'g',f, psd_006.power_right,'--g',f,psd_007.power_left ,'og')
plot(f,psd_003.power_combined,'b',f, psd_006.power_combined,'--b',f,psd_007.power_combined ,'ob')
legend('hc 13','hc 19','hc 20', 'ab 3 s','ab 6 s','ab 7 s', 'ab 3 ns','ab 6 ns','ab 7 ns', 'ab 3 b','ab 6 b','ab 7 b')
xlim([5 30])
xlabel('Frequency')
ylabel('Power')

%%%
%%% Normalized power
%%% 6 has no bump, 7 has no bump, 3 has a large bump (and is higher in non
%%% spiking SOZ -- corresponds to our density plots)
%%% Bumps in 19 and 20; 13 is flat
%%% When averaged out sigma beta ratio is higher in HC (5 x) than in active
%%% (3 x)

%% Compute bumps

sum(hc_spectra(f>=10 & f<15))/sum(hc_spectra(f>=15 & f<20))
sum(aBECTS_spiking_focus(f>=10 & f<15))/sum(aBECTS_spiking_focus(f>=15 & f<20))
sum(aBECTS_nonspiking_focus(f>=10 & f<15))/sum(aBECTS_nonspiking_focus(f>=15 & f<20))
sum(aBECTS_combined(f>=10 & f<15))/sum(aBECTS_combined(f>=15 & f<20))


v = psd_003.power_combined;
sum(v(f>=10 & f<15))/sum(v(f>=15 & f<20));

