clc,clear;
close all;
Iold = imread('E:\NCKU_experimental\IN718\180_800_3\3.bmp');
el = 5000;     %experimental length (sample) 
%the perspective matrix need matrix
x1 = 71;y1 = 196;
x3 = 85;y3 = 315;
x7 = 331;y7 = 186;
x9 = 345;y9 = 305;
%畒夹锣传
% T = TransImage(Iold,99,36,109,226,393,30,414,217); % 150_1200
% T = TransImage(Iold,71,29,86,223,364,19,383,208); %200_1200
% T = TransImage(Iold,67,40,88,234,362,34,387,220); % 250_1200
T = TransImage(Iold,x1,y1,x3,y3,x7,y7,x9,y9); % 300_1200


% Iold = double(Iold)
T = double(T)

%% 耝獺腹
% т程癟腹ê︽
% setp1: 盢痻皚<maxㄧ计琌т︽程跑︽碞т–︽程碞琌–程
% step2: т程竚
[M,index] = max(T)  %step1     
[m in] = max(M)         %step2
TS = T(:,in); % Target Signal

%% signal filter
% figure,
% subplot(2,2,1),imshow(Iold)
% subplot(2,2,2),plot(Iold(in,:))
% subplot(2,2,3),imshow(IT)
% subplot(2,2,4),plot(IT(91,:))

% figure,
% plot(xl,Iold(in,:))

L = fourierLowPass(TS',30,100);

d1 = diff(L)*10;
d2 = diff(d1);
d3 = diff(d2);%......
d4 = diff(d3);%........
[val ind] = min(d2);

%% 璸衡ㄏノ锣传pixel length
pl = el/(x7-x1);     %pixel length
xL1 = [1:1:size(L,2)]*(pl);
x2 = [1:1:size(d1,2)]*(pl);
x3 = [1:1:size(d2,2)]*(pl);
x4 = [1:1:size(d3,2)]*(pl);
x5 = [1:1:size(d4,2)]*(pl);
figure(),
plot(xL1,L,'LineWidth',5);hold on
plot(x2,d1)
plot(x3,d2,'LineWidth',5)
plot(x4,d3,'LineWidth',1)
plot(x5,d4,'LineWidth',1)
%% width algorithm
% [label,number]= bwlabel (T , 8);
% Label = regionprops (label,'basic');  %%% mark calibration bar
% [~,idx] = max([Label.Area]);   
% [G]=Label(idx).BoundingBox;            
% length = G(3).*pl;
% width = G(4).*pl;