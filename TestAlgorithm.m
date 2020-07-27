% %%%%%%%%%%%%%%%%%%%
% Test the new algorithm find threshold
% Date: 2020/05/07
% @ Castro
% %%%%%%%%%%%%%%%%%
clc,clear
close all
Iold = imread('E:\NCKU_experimental\0819result\200_1200\200W_1200_1.bmp'); % uisng png/bmp file
Binary_Iold = Iold;
%Iold = rgb2gray(Iold);
% Perspective the transformation
el = 5000;
x1 =87;y1 = 217;
x3 = 98;y3 = 334;
x7 = 357;y7 = 208;
x9 = 369;y9 = 320;
T = TransImage(Iold,x1,y1,x3,y3,x7,y7,x9,y9);
pl = el/(x7-x1)
% Data Transform
T = double(T);
% Find the maximum algorithm
[M,index] = max(T');  %step1     
[m in] = max(M);         %step2
TS = T(in,:); % Target Signal

% filer using the 1-D Fourier Lowpass Filter
L = fourierLowPass(TS,50,100);
DL1 = diff(L); % First derivative
DL2 = diff(DL1); % Second derivative
% Data Lengh
xL1 = [1:1:size(L,2)]*(pl);
x2 = [1:1:size(DL1,2)]*(pl);
x3 = [1:1:size(DL2,2)]*(pl);
%% find the maximum location of 1st derivative and watch the video 
[~,location] = max(DL1);
threshold = L(1,location);

% find the meltpool shape
for i = 1:1:size(Iold,1)
    for j = 1:1:size(Iold,2)
        if Iold(i,j) < threshold
            Binary_Iold(i,j) = 0;
        end
    end
end
figure,
imshow(Iold,'Border','tight','InitialMagnification', 800)
figure,
imshow(Binary_Iold,'Border','tight','InitialMagnification', 800)
for i = 1:1:size(Binary_Iold,1)
    for j = 1:1:size(Binary_Iold,2)
        if Binary_Iold(i,j)>0
            Binary_Iold(i,j)=255;
        end
    end
end
figure,imshow(Binary_Iold,'Border','tight','InitialMagnification', 800)
Binary_Iold = double(Binary_Iold);

[label,number]= bwlabel (Binary_Iold , 8);
Label = regionprops (label,'Area','Centroid','BoundingBox','PixelList');  %%% mark calibration bar
[~,idx] = max([Label.Area]);   
[G]=Label(idx).BoundingBox;            
length = G(3).*pl;
width = G(4).*pl;

final = Binary_Iold;
seg = zeros(size(Binary_Iold,1),size(Binary_Iold,2));
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


