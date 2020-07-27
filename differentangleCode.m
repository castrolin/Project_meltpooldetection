%%%%%%%%%%%%%%%%%%%%%%%%%%
% Detection Different Angle
% Date: 2020/05/04
% @Creator: Castro lin
% Test the Data: 400_67 600_67 800_67
% This code is test only!!
%%%%%%%%%%%%%%%%%%%%%%%%%%%
close all
clc,clear
%% reade file
Iold = imread('E:\NCKU_experimental\0427Result\400\67Result\10.bmp');
el = 10000;     %experimental length (sample) 
%the perspective matrix need matrix
x1 = 4;y1 = 133;
x3 = 3;y3 = 408;
x7 = 510;y7 = 116;
x9 = 507;y9 = 389;
%座標轉換 image Rotated
T = TransImage(Iold,x1,y1,x3,y3,x7,y7,x9,y9);
Tr = imrotate(T,-90);
Binary_Iold = Tr; %要將圖片cut melt pool only;
T = double(T);
Tr = double(Tr);
%%  Analysis the angle
[M,index] = max(Tr')  %step1     
[m in] = max(M)         %step2
TS = Tr(in,:); % Target Signal
%--------------------------------------------------
[M2,index2] = max(double(Tr'))  %step1     
[m2 in2] = max(M2)         %step2
[~,windex2] = max(double(Tr(in2,:)));
TSWidth = double(Tr(:,windex2));
figure,
plot(Tr(in2,:),'LineWidth',7); grid on
xlabel('Position[Pixel index]','FontSize',30)
xlim([0 260]);
ylabel('Intensity (gray-scale level)','Fontsize',30)
set(gca,'FontSize',30)
figure,
plot(Tr(:,windex2),'LineWidth',7);grid on
title('Position[Pixel index]','FontSize',30)
xlim([0 130]);
ylabel('Intensity (gray-scale level)','Fontsize',30)
set(gca,'FontSize',30)
%% 1-D Fourier Lowpass filter to fit the data
L = fourierLowPass(TS,50,100);
LW = fourierLowPass(TSWidth',50,100);

d1 = diff(L)*10;
d2 = diff(d1);
d3 = diff(d2);%......
d4 = diff(d3);%........
d1t = zeros(size(d1));
d1t(1,:) = d1(1,:);
d2t = zeros(size(d1));
for u = 1:1:size(d1)
    d2t(1,u)= d2(1,u);
end
dd = zeros(size(d1));
dd = d1t-d2t; % first - second;
% width
dw1 = diff(LW)*10;
dw2 = diff(dw1);
%ExpSim(L)

%% 計算長度使用轉換後的pixel length
pl = el/(x7-x1);     %pixel length resolution -> real
xL1 = [1:1:size(Tr,2)]%*(pl);
x2 = [1:1:size(d1,2)]%*(pl);
x3 = [1:1:size(d2,2)]%*(pl);
x4 = [1:1:size(d3,2)]%*(pl);
x5 = [1:1:size(d4,2)]%*(pl);

%% lengthe Scale
xL1 = [1:1:size(Tr,2)]*(pl);
x2 = [1:1:size(d1,2)]*(pl);
x3 = [1:1:size(d2,2)]*(pl);
x4 = [1:1:size(d3,2)]*(pl);
x5 = [1:1:size(d4,2)]*(pl);
%  width Scale
xw1 = [1:1:size(LW,2)]*(pl);
xw2 = [1:1:size(dw1,2)]*(pl);
xw3 = [1:1:size(dw2,2)]*(pl);
%% Plot the Length Signal
figure(),
plot(xL1,L,'LineWidth',5);hold on
plot(x2,d1,'LineWidth',5)
plot(x3,d2,'LineWidth',5)
xlabel("distance(um)","FontSize",30)
%xlim([2300 5000])
ylabel("intensity (graylevel)","FontSize",30)
legend1 = legend({'raw data','first derivative','second derivative'},'FontSize',20);
set(legend1,'Location','northwest','FontSize',30)
title("Signal","FontSize",30)
%% Plot the Widh Signal
figure(),
plot(xw1,LW,'LineWidth',5);hold on
plot(xw2,dw1,'LineWidth',5)
plot(xw3,dw2,'LineWidth',5)
xlabel("distance(um)","FontSize",30)
% xlim([2300 5000])
ylabel("intensity (graylevel)","FontSize",30)
legend1 = legend({'raw data','first derivative','second derivative'},'FontSize',20);
set(legend1,'Location','northwest','FontSize',30)
title("Signal_Width","FontSize",30)

%% cut the intensity
for i = 1:1:size(Tr,1)
    for j = 1:1:size(Tr,2)
        if Tr(i,j) < 148.5
            Tr(i,j) = 0;
        end
    end
end
figure,
imshow(Tr,'Border','tight','InitialMagnification', 800)


[label,number]= bwlabel (Tr , 8);
Label = regionprops (label,'Area','Centroid','BoundingBox','PixelList');  %%% mark calibration bar
[~,idx] = max([Label.Area]);   
[G]=Label(idx).BoundingBox;            
length = G(3).*pl;
width = G(4).*pl;

final = Tr;
seg = zeros(size(Tr,1),size(Tr,2));
if size(Label,1)~=1
    for a = 1:number
        if(Label(a).Area<Label(idx).Area)
            onesmall = Label(a).PixelList;
            for i = 1:size(onesmall,1)
                seg(onesmall(i,2),onesmall(i,1)) =255;
            end
            seg = uint8(seg);
            se = strel('disk',5);
            seg = imdilate(seg,se);
            final = final - double(seg);
        end
    end
end
figure,imshow(final,'Border','tight','InitialMagnification', 800)
figure,imshow(uint8(final),'Border','tight','InitialMagnification', 800)

