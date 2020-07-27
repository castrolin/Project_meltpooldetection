%###################################
% imagine analysis
% 8/19 experimental
% 8/20 using code analysis
% 8/21 add the transform axis code
%10/3 modify code
%10/5 create new algorithm (second derivitive)
    %How to find the correct point of second deritive
    %In line 71 need modify.
%11/6 IN718 width new measurement
    % the new algorithm have not complete.
%12/2 add new data in the second!
%2020/05/04 add the spatter seperation
    % Find the beautiful and clearly figure to explanation Algorithm
    % Maybe 10.bmp ?????
%####################################
clc,clear;
close all;  
Iold = imread('E:\NCKU_experimental\0427Result\600\Testimage\2.bmp'); %'E:\NCKU_experimental\IN718\180_800_3\2.bmp' E:\video\image\150W_600mms.bmp E:\video\image\300W_600mms\2.bmp
%Iold = rgb2gray(Iold);
%Inconel file location 'E:\NCKU_experimental\IN718\180_600\3.bmp'
Binary_Iold = Iold; %要將圖片cut melt pool only;
el = 10000;     %experimental length (sample) 
%the perspective matrix need matrix
x1 = 48;y1 = 179;
x3 = 59;y3 = 380;
x7 = 505;y7 = 154;
x9 = 509;y9 = 353;
%座標轉換
% T = TransImage(Iold,99,36,109,226,393,30,414,217); % 150_1200
% T = TransImage(Iold,71,29,86,223,364,19,383,208); %200_1200
% T = TransImage(Iold,67,40,88,234,362,34,387,220); % 250_1200
T = TransImage(Iold,x1,y1,x3,y3,x7,y7,x9,y9); % 300_1200


% Iold = double(Iold)
T = double(T)

%% 擷取信號
% 找出最大的訊號在那一列
% setp1: 先將矩陣轉置<為max函數是找出行的最大值，因此列變行，就能找出每一行的最大值也就是每一列的最大值
% step2: 在找出最大值的列的位置
[M,index] = max(T')  %step1     
[m in] = max(M)         %step2
TS = T(in,:); % Target Signal
%--------------------------------------------------
[M2,index2] = max(double(Iold'))  %step1     
[m2 in2] = max(M2)         %step2
[~,windex2] = max(double(Iold(in2,:)));
TSWidth = double(Iold(:,windex2));
figure,
plot(Iold(in2,:),'LineWidth',7); grid on
xlabel('Position[Pixel index]','FontSize',30)
xlim([0 260]);
ylabel('Intensity (gray-scale level)','Fontsize',30)
set(gca,'FontSize',30)
figure,
plot(Iold(:,windex2),'LineWidth',7);grid on
title('Position[Pixel index]','FontSize',30)
xlim([0 130]);
ylabel('Intensity (gray-scale level)','Fontsize',30)
set(gca,'FontSize',30)
%% signal filter
% figure,
% subplot(2,2,1),imshow(Iold)
% subplot(2,2,2),plot(Iold(in,:))
% subplot(2,2,3),imshow(IT)
% subplot(2,2,4),plot(IT(91,:))

% figure,
% plot(xl,Iold(in,:))
%L = TS;
L = fourierLowPass(TS,50,100);
LW = fourierLowPass(TSWidth',50,100);
%Length numerical
%ExpSim(L);
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
% figure,
% plot(dd)
% [val ind] = min(d2);
%ExpSim(L)

%% 計算長度使用轉換後的pixel length
pl = el/(x7-x1);     %pixel length resolution -> real
%pl = 1; % index differnt;
xL1 = [1:1:size(T,2)]%*(pl);
x2 = [1:1:size(d1,2)]%*(pl);
x3 = [1:1:size(d2,2)]%*(pl);
x4 = [1:1:size(d3,2)]%*(pl);
x5 = [1:1:size(d4,2)]%*(pl);

%% autodetect algorithm (find second derivite)
% [value1,~] = max(d1);
% [value2,~] = max(abs(d1));
% [~,indexmax]=max(L);
% [~,indexmin]=min(L);
% if (value1-value2)>0 || (value1-value2) <0%turn right
%     t = d2(1,:); %先將d2存成另一矩陣在計算，不然沒辦畫圖
%     [~,indexd2]=min(t);
%     n=0;
%     while(1)  %找尋第二微分的特徵
%         [~,indexMin] = min(t(1,1:indexd2));   %抓頭到最小的位置
% %         indexstart = indexMin;
%         t(1,indexMin)=0; %找到最小把它設為0
%         index3 = indexMin;
%         indexL = ((indexmax*L(1,indexmin)-indexmin*L(1,indexmax))/(L(1,indexmin)-L(1,indexmax)))+(L(1,index3)*(indexmin-indexmax)/(L(1,indexmin)-L(1,indexmax)));
%          %線性方程式,找出與轉換點同值的位置,才能計算長度
%         Length = abs((indexL-index3)*pl);
%         if (Length < 600 && Length > 450 )
%             break;
%         end
%         n=n+1;
%         if n>13
%             break;
%         end
%     end
% end
% if (value1-value2) == 0 %turn left
%     t = d2(1,:); %先將d2存成另一矩陣在計算，不然沒辦畫圖
%     [~,indexd2]=min(t);
%     n=0;
%     while(1)  %找尋第二微分的特徵
%         [~,indexMin] = min(t(1,indexd2:end));    %抓最小值的位置到最後
% %         indexstart = indexMin;
%         inchange = indexMin+(indexd2-1)
%         t(1,inchange)=0; %找到最小把它設為0
%         index3 = indexMin;
%         indexL = ((indexmax*L(1,indexmin)-indexmin*L(1,indexmax))/(L(1,indexmin)-L(1,indexmax)))+(L(1,index3)*(indexmin-indexmax)/(L(1,indexmin)-L(1,indexmax)));
%          %線性方程式,找出與轉換點同值的位置,才能計算長度
%         Length = abs((indexL-index3)*pl);
%         if (Length < 600 && Length > 450 )
%             break;
%         end
%         n=n+1;
%     end
% end
% indexvalue = floor(indexL)
%% lengthe Scale
xL1 = [1:1:size(T,2)]*(pl);
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

% figure(),
% plot(xL1,abs(L),'LineWidth',5);%hold on
% title('Experiment data intensity distribution','Fontsize',24)
% xlabel('(micrometer)','Fontsize',24);
% xlim([3000 6000])
% ax = gca;
% ax.FontSize = 12;
% ylabel('intensity','Fontsize',24)
% 
% figure,
% plot(xL1,L,'LineWidth',5);%hold on
% title('Experiment data intensity distribution','Fontsize',24)
% xlabel('(micrometer)','Fontsize',24);
% xlim([4390 4790])
% ax = gca;
% ax.FontSize = 12;
% ylabel('Intensity','Fontsize',24)
% 
% figure(),
% plot(x2,d1,'LineWidth',5)
% xlabel('(micrometer)','Fontsize',24);
% %xlim([4390 4790])
% ax = gca;
% ax.FontSize = 12;
% ylabel('First derivative','Fontsize',24)
% 
% figure(),
% plot(x3,d2,'LineWidth',5)
% xlabel('(micrometer)','Fontsize',24);
% %xlim([4390 4790])
% ax = gca;
% ax.FontSize = 12;
% ylabel('Second derivative','Fontsize',24)

% xlabel("distance(um)","FontSize",20)
% ylabel("intensity","FontSize",20)
% legend('original','first','second')
% title("Signal","FontSize",20)
% plot(x4,d3,'LineWidth',1)
% plot(x5,d4,'LineWidth',1)
%% 標助線
% plot([index3*pl indexvalue*pl],[L(1,index3) L(1,indexvalue)],'r-o','LineWidth',3)
% plot([index3*pl index3*pl],[d4(1,index3) L(1,indexvalue)],'b-o','LineWidth',3)
% 
% text('FontSize',18,'String','<== transition',...
%     'Position',[3789.12010368664 136.292322604931 0]);
% 
% % Create text
% text('FontSize',18,'String','Length: 656 um',...
%     'Position',[3123.23588709677 157.142857142857 0]);
% 
% grid on
% title('180W with 800m/s','FontSize',18)
% xlabel('distance [um]','FontSize',18)
% ylabel('illumination','FontSize',18)
% legend('original','first','second','3rd','4th')
%% cut the intensity
for i = 1:1:size(Iold,1)
    for j = 1:1:size(Iold,2)
        if Iold(i,j) < 130
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











