% rewrite the image formate
% jpg to bmp
% 2020/01/13
% Editor : Ze Hong Lin
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

pathL = 'E:\Meltpool_image\Left\*.jpg';
pathM = 'E:\Meltpool_image\Middle\*.jpg';
pathR = 'E:\Meltpool_image\Right\*.jpg';
imdsL = imageDatastore(pathL);
imdsM = imageDatastore(pathM);
imdsR = imageDatastore(pathR);

for k = 1:size(imdsL.Files,1)
    oi = imread(imdsL.Files{k});   % read original image
%     oi = imresize(oi,[256 128]);
   FileName = fullfile('E:\Melpool_bmp\Left',sprintf('%d.png',k));
   imwrite(oi,FileName);
end
for k = 1:size(imdsM.Files,1)
    oi = imread(imdsM.Files{k});   % read original image
%     oi = imresize(oi,[256 128]);
   FileName = fullfile('E:\Melpool_bmp\Middle',sprintf('%d.png',k));
   imwrite(oi,FileName);
end
for k = 1:size(imdsR.Files,1)
    oi = imread(imdsR.Files{k});   % read original image
%     oi = imresize(oi,[256 128]);
   FileName = fullfile('E:\Melpool_bmp\Right',sprintf('%d.png',k));
   imwrite(oi,FileName);
end