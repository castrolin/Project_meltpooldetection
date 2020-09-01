%% the time series analysis
% The data from 1.keyhole,2.lack of fusion,3.Normal
% frequency analysis
% Date:2020/08/05
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear,clc
close all
%% The fixed parameter and Import data
Datakey = load(fullfile('E:\NCKU_experimental\Project_metlpoolDetection\Defects_analysis','keyholeone.mat'));
Databall = load(fullfile('E:\NCKU_experimental\Project_metlpoolDetection\Defects_analysis','ballingone.mat'));
Data = load(fullfile('E:\NCKU_experimental\Project_metlpoolDetection\Defects_analysis\layerdatabase','160um.mat'));
fps = 4000; %frame per second 
%% prepare the data
data_series = [Data.shape(1:end).Ratio];
data_key= [Datakey.shape(1:end).Ratio];
data_ball= [Databall.shape(1:end).Ratio];

time_axis = (1:size(data_series,2))/fps;
time_axis_key = (1:size(data_key,2))/fps;
time_axis_ball = (1:size(data_ball,2))/fps;

%% figure plot the ratio along with time
figure,plot(time_axis,data_series)
       set(gca,'FontSize',20)
       title('Signal(Normal)','FontSize',30)
       xlabel('Time(s)','FontSize',28)
       ylabel('Ratio(Dimesionless)','FontSize',28)
figure,plot(time_axis_key,data_key)
       set(gca,'FontSize',20)
       title('Signal(Higher Energy)','FontSize',30)
       xlabel('Time(s)','FontSize',28)
       ylabel('Ratio(Dimesionless)','FontSize',28)
figure,plot(time_axis_ball,data_ball)
       set(gca,'FontSize',20)
       title('Signal(Lower Energy)','FontSize',30)
       xlabel('Time(s)','FontSize',28)
       ylabel('Ratio(Dimesionless)','FontSize',28)
%%
N = size(data_series,2); % Number of data
N1 = size(data_key,2);
N2 = size(data_ball,2);
%% frequency analysis (Fast fourier analysis: Original data)
length_FFT = 2.^nextpow2(N);
FFT_signal = fft(data_series,length_FFT);
FFT_signal = FFT_signal(1:length_FFT/2);

frequency = N.*(0:(length_FFT/2)-1)/length_FFT;
figure,plot(frequency,abs(FFT_signal/max(FFT_signal)));
       set(gca,'FontSize',20)
       title('Fourier Transform(Normal)','FontSize',30)
       xlabel('Frequency (Hz)','FontSize',28)
       ylabel('Amplitude','FontSize',28)
%ylim([0 0.1]);
%xlim([0 500]);

%----------------------------------------------
length_FFTkey = 2.^nextpow2(N1);
FFT_signalkey = fft(data_key,length_FFTkey);
FFT_signalkey = FFT_signalkey(1:length_FFTkey/2);

freqkey = N1.*(0:(length_FFTkey/2)-1)/length_FFTkey;
figure,plot(freqkey,abs(FFT_signalkey/max(FFT_signalkey)));
       set(gca,'FontSize',20)
       title('Fourier Transform(Higher Energy)','FontSize',30)
       xlabel('Frequency (Hz)','FontSize',28)
       ylabel('Amplitude','FontSize',28)
%ylim([0 0.1]);
xlim([0 500]);
%-----------------------------------------------------
length_FFTball = 2.^nextpow2(N2);
FFT_signalball = fft(data_ball,length_FFTball);
FFT_signalball = FFT_signalball(1:length_FFTball/2);

freqball = N2.*(0:(length_FFTball/2)-1)/length_FFTball;
figure,plot(freqball,abs(FFT_signalball/max(FFT_signalball)));
       set(gca,'FontSize',20)
       title('Fourier Transform(Lower Energy)','FontSize',30)
       xlabel('Frequency (Hz)','FontSize',28)
       ylabel('Amplitude','FontSize',28)
%ylim([0 0.1]);
xlim([0 100]);
%% Low-pass filter
% L=20;
% fc =150;
% 
% % x = fft(data_series);
% hsupp = (-(L-1)/2:(L-1)/2);
% hideal = (2*fc/fps)*sinc(2*fc*hsupp/fps);
% h = hamming(L)'.*hideal;
% length_x = 2.^nextpow2(L+N-1);
% 
% xzp=[data_series zeros(1,length_x-N)];
% hzp=[h zeros(1,length_x-L)];
% 
% X = fft(xzp);
% H = fft(hzp);
% Y = X.*H;
% y = ifft(Y);
% figure,
% subplot(1,3,1),plot(y,'r-');hold on
%                plot(data_series,'b-');hold off
% subplot(1,3,2),plot(y,'r-')
% subplot(1,3,3),plot(data_series,'b-')
%% gussian low pass filter
% y = fourierLowPass(data_series,50,100);
% 
% subplot(1,3,1),plot(y,'r-');hold on
%                plot(data_series,'b-');hold off
% subplot(1,3,2),plot(y,'r-')
% subplot(1,3,3),plot(data_series,'b-')
%% autocorrelation
y=autocorr(data_series,'NumLags',600);
y1=autocorr(data_key,'NumLags',600);
y2=autocorr(data_ball,'NumLags',600);
figure,plot(y)
       set(gca,'FontSize',20)
       title('Testing','FontSize',30)
       xlabel('Number of Data','FontSize',28)
       ylabel('ACF','FontSize',28)
figure,plot(y1)
       set(gca,'FontSize',20)
       title('Higher Energy','FontSize',30)
       xlabel('Number of Data','FontSize',28)
       ylabel('ACF','FontSize',28)
figure,plot(y2)
       set(gca,'FontSize',20)
       title('Lower Energy','FontSize',30)
       xlabel('Number of Data','FontSize',28)
       ylabel('ACF','FontSize',28)
%% correlation between the key adn lack and normal
r1 = xcorr(data_key(1:1716),data_ball(1:1716));
r2 = xcorr(data_key(1:1716),data_series(1:1716));
r3 = xcorr(data_ball(1:1716),data_series(1:1716));

%% FFT for autocorelation signal (The length of data must be same)
length_Auto = 2.^nextpow2(size(y,2));
FFT_Auto = fft(y,length_Auto);
FFT_Auto = FFT_Auto(1:length_Auto/2);

freq_Auto = size(y,2).*(0:(length_Auto/2)-1)/length_Auto;
figure,plot(freq_Auto,abs(FFT_Auto/max(FFT_Auto)));
       set(gca,'FontSize',20)
       title('Fourier Transform(Normal)','FontSize',30)
       xlabel('Frequency (Hz)','FontSize',28)
       ylabel('Amplitude','FontSize',28)

%ylim([0 0.1]);
xlim([0 100]);
%------------------------------------------------------------
length_Autokey = 2.^nextpow2(size(y1,2));
FFT_Autokey = fft(y1,length_Autokey);
FFT_Autokey = FFT_Autokey(1:length_Autokey/2);

freq_Autokey = size(y1,2).*(0:(length_Autokey/2)-1)/length_Autokey;
figure,plot(freq_Autokey,abs(FFT_Autokey/max(FFT_Autokey)));
       set(gca,'FontSize',20)
       title('Fourier Transform(Higher Energy)','FontSize',30)
       xlabel('Frequency (Hz)','FontSize',28)
       ylabel('Amplitude','FontSize',28)
xlim([0 100])
%---------------------------------------------------------------
length_Autoball = 2.^nextpow2(size(y2,2));
FFT_Autoball = fft(y2,length_Auto);
FFT_Autoball = FFT_Autoball(1:length_Autoball/2);

freq_Autoball = size(y2,2).*(0:(length_Autoball/2)-1)/length_Autoball;
figure,plot(freq_Autoball,abs(FFT_Autoball/max(FFT_Autoball)));
       set(gca,'FontSize',20)
       title('Fourier Transform(Lower Energy)','FontSize',30)
       xlabel('Frequency (Hz)','FontSize',28)
       ylabel('Amplitude','FontSize',28)
xlim([0 100]);
