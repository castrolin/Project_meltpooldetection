function [length, width] = BinaryPP(Iold,threshold,pixelLength)
%     se = strel('rectangle',[10 5]);
    Bw  = zeros(size(Iold,1),size(Iold,2));
    Iold = rgb2gray(Iold);
    Binary_Iold = Iold;
    for i = 1:1:size(Iold,1)
    for j = 1:1:size(Iold,2)
        if Iold(i,j) < threshold
            Binary_Iold(i,j) = 0;
        end
    end
end
% figure,
% imshow(Iold)
% figure,
% imshow(Binary_Iold)
for i = 1:1:size(Binary_Iold,1)
    for j = 1:1:size(Binary_Iold,2)
        if Binary_Iold(i,j)>0
            Binary_Iold(i,j)=255;
        end
    end
end
% Bw = imerode(Binary_Iold,se);
% Bw = bwareaopen(Bw,70);
% % Bw = imdilate(Bw,se);
% figure,imshow(Bw)

figure,
    subplot(1,3,1),imshow(Iold)
    subplot(1,3,2),imshow(Binary_Iold)
    
Binary_Iold = double(Binary_Iold);

[label,number]= bwlabel (Binary_Iold , 8);
Label = regionprops (label,'basic');  %%% mark calibration bar
[~,idx] = max([Label.Area]);   
[G]=Label(idx).BoundingBox;            
length = G(3).*pixelLength;
width = G(4).*pixelLength;
end