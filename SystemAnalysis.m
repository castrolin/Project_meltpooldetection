% %%%%%%%%%%%%%%%%%%%%%
% Data Processing
% System test
% @Creator: CastroLin
% Date:2020/05/08
% %%%%%%%%%%%%%%%%%%%%%
clc,clear
close all
sys400 = load('400databank.mat');
sys600 = load('600databank.mat');
sys800 = load('800databank.mat');
%%
% 400reasult(1:size()) = ...
%     struct('Shape',zeros(TransHeight,TransWidth,'uint8'),...
%             'Length',0,....
%             'Width',0,...
%             'Ratio',0)

%% 400 1:Sample number 2: Length 3: Width 4: Ratio
%result400 = zeros(4,size([sys400.shape.Length],2));
n= 1;
outlier400num = 0;
for i = 1:size([sys400.shape.Length],2)
    result400(1,n) = i;
    result400(2,n) = sys400.shape(i).Length;
    result400(3,n) = sys400.shape(i).Width;
    result400(4,n) = sys400.shape(i).Ratio;
    n = n+1;
end
        
%% 600 1:Sample number 2: Length 3: Width 4: Ratio
%result600 = zeros(4,size([sys600.shape.Length],2));
n= 1;
outlier600num = 0;
for i = 1:size([sys600.shape.Length],2)
    result600(1,n) = i;
    result600(2,n) = sys600.shape(i).Length;
    result600(3,n) = sys600.shape(i).Width;
    result600(4,n) = sys600.shape(i).Ratio;
    n = n+1;
end
%% 800 1:Sample number 2: Length 3: Width 4: Ratio
%result800 = zeros(4,size([sys800.shape.Length],2));
n= 1;
outlier800num = 0;
for i = 1:size([sys800.shape.Length],2)
    result800(1,n) = i;
    result800(2,n) = sys800.shape(i).Length;
    result800(3,n) = sys800.shape(i).Width;
    result800(4,n) = sys800.shape(i).Ratio;
    n = n+1;
end

%% plot the reuslt
figure,
title('length')
subplot(1,3,1),plot(result400(2,:))
                xlabel('400')
subplot(1,3,2),plot(result600(2,:))
                xlabel('600')
subplot(1,3,3),plot(result400(2,:))
                xlabel('800')

figure,
title('width')
subplot(1,3,1),plot(result400(3,:))
                xlabel('400')
subplot(1,3,2),plot(result600(3,:))
                xlabel('600')
subplot(1,3,3),plot(result400(3,:))
                xlabel('800')
%% statiscal analysis
Length400avg = mean(result400(2,:));
std400Length = std(result400(2,:));
Width400avg = mean(result400(3,:));
std400width = std(result400(3,:));

Length600avg = mean(result600(2,:));
std600Length = std(result600(2,:));
Width600avg = mean(result600(3,:));
std600width = std(result600(3,:));

Length800avg = mean(result800(2,:));
std800Length = std(result800(2,:));
Width800avg = mean(result800(3,:));
std800width = std(result800(3,:));

%% Fourier Transform
fps = 5; %caemra setting and it is sample rate
% Realpart % this can see the frequency domain
length_FFT_result400 = 2.^nextpow2(size(result400(2,:),2));
length_FFT_result600 = 2.^nextpow2(size(result600(2,:),2));
length_FFT_result800 = 2.^nextpow2(size(result800(2,:),2));

FFT_result400 = fft(result400(2,:),length_FFT_result400);
FFT_result600 = fft(result600(2,:),length_FFT_result600);
FFT_result800 = fft(result800(2,:),length_FFT_result800);
% Take half of frequency because the whole signal was extracted we will face to symmtrical prob.
FFT_result400 = FFT_result400(1:length_FFT_result400/2);
FFT_result600 = FFT_result600(1:length_FFT_result600/2);
FFT_result800 = FFT_result800(1:length_FFT_result800/2);
% frequency witten
frequency_400 = size(result400(2,:),2).*(0:length_FFT_result400 /2 -1)/length_FFT_result400;
frequency_600 = size(result600(2,:),2).*(0:length_FFT_result600 /2 -1)/length_FFT_result600;
frequency_800 = size(result800(2,:),2).*(0:length_FFT_result800 /2 -1)/length_FFT_result800;

figure,
subplot(1,3,1),plot(frequency_400,abs(FFT_result400/max(FFT_result400)))
               xlabel('400')
subplot(1,3,2),plot(frequency_600,abs(FFT_result600/max(FFT_result600)))
               xlabel('600')
subplot(1,3,3),plot(frequency_800,abs(FFT_result800/max(FFT_result800)))
               xlabel('800')

%% W/L ratio test and plot
figure,plot(result400(3,:).*result400(2,:).^-1,'o')
figure,plot(result600(3,:).*result600(2,:).^-1,'o')
figure,plot(result800(3,:).*result800(2,:).^-1,'o')

per400 = result400(3,:).*result400(2,:).^-1;
per600 = result600(3,:).*result600(2,:).^-1;
per800 = result800(3,:).*result800(2,:).^-1;

re400=0;
out400=0;
for i = 1:size(per400,2)
    if(per400(1,i)<1 && per400(1,i)>0.5)
        re400 = re400+1;
    else
        out400 =out400+1;
    end
end
re600=0;
out600=0;
for i = 1:size(per600,2)
    if(per600(1,i)<1 && per600(1,i)>0.5)
        re600 = re600+1;
    else
        out600 =out600+1;
    end
end
re800=0;
out800=0;
for i = 1:size(per800,2)
    if(per800(1,i)<1 && per800(1,i)>0.5)
        re800 = re800+1;
    else
        out800 =out800+1;
    end
end

outlier400per = out400/size(per400,2);
outlier600per = out600/size(per600,2);
outlier800per = out800/size(per800,2);


%%  signal lowpass filter(design the lowpass filter)
siganl = result400(2,:);
% ffsignal = fft(siganl,size(siganl,2));
% resignal = lowpass(ffsignal,0.008);
% figure,plot(real(resignal))
% finalsignal = ifft(resignal,size(siganl,2));
figure,
subplot(1,2,1),plot(siganl)
subplot(1,2,2),plot(finalsignal)





