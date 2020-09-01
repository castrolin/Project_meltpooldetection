% %%%%%%%%%%%%%%%
% Video auto detection of the threshold
% Date: 2020/05/07
% work progress
% 2020/07/27: Analysis defects video
% 2020/08/15: Analysis layerchage video 20 to 160
% @Creator: CastroLin
% %%%%%%%%%%%%%%%%
clc,clear
close all
%% Input the video file
obj=VideoReader('E:\NCKU_experimental\defects\layerthickness_change\160um.avi'); %讀檔
nFrames =obj.numberOfFrames;%　nframes 為影片禎數
vidHeight = obj.Height;
vidWidth = obj.Width;
n=1;
frame_grabed=nFrames;
I=ones(vidHeight,vidWidth,frame_grabed);% original image prolocated
I=uint8(I);
%% Preallocate movie structure.
mov(1:nFrames/n) = ...
    struct('cdata', zeros(vidHeight, vidWidth, 3, 'uint8'),...
           'colormap', []);
%% Read one frame at a time.
for k = 1 : nFrames/n
    mov(k).cdata = read(obj, k);
    k
end
el = 10000;
x1 = 3;y1 = 84;
x3 = 3;y3 = 365;
x7 = 510;y7 = 96;
x9 = 510;y9 = 379;
pl = el/(x7-x1);
%% detect the transforming Image size
zeroI = TransImage((mov(1).cdata),x1,y1,x3,y3,x7,y7,x9,y9);
TransHeight = size(zeroI,1);
TransWidth = size(zeroI,2);
%% shape structure
shape(1:nFrames) = ...
    struct('Shape',zeros(TransHeight,TransWidth,'uint8'),...
            'Length',0,....
            'Width',0,...
            'Ratio',0)


%% Start inspection
for sample = 1:nFrames
    Iold = mov(sample).cdata;
    Binary_Iold = Iold;
    T = TransImage(Iold,x1,y1,x3,y3,x7,y7,x9,y9);
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
    xL2 = [1:1:size(DL1,2)]*(pl);
    xL3 = [1:1:size(DL2,2)]*(pl);
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
%     figure,
%     imshow(Iold,'Border','tight','InitialMagnification', 800)
%     figure,
%     imshow(Binary_Iold,'Border','tight','InitialMagnification', 800)
    for i = 1:1:size(Binary_Iold,1)
        for j = 1:1:size(Binary_Iold,2)
            if Binary_Iold(i,j)>0
                Binary_Iold(i,j)=255;
            end
        end
    end
%     figure,imshow(Binary_Iold,'Border','tight','InitialMagnification', 800)
    Binary_Iold = double(Binary_Iold);

    [label,number]= bwlabel (Binary_Iold , 8);
    Label = regionprops (label,'Area','Centroid','BoundingBox','PixelList');  %%% mark calibration bar
    [~,idx] = max([Label.Area]);
    if isempty(idx) == 1
       sample
    else
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
    end
    shape(sample).Length  = length;
    shape(sample).Width = width;
    shape(sample).Shape = final;
    shape(sample).Ratio = width/length;
    clear Iold
    clear Binary_Iold
    clear T
end
