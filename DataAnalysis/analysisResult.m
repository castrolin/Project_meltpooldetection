% see the  figure of the result
% show the ratio and length and figure
% final step import exel file
%D=load('E:\NCKU_experimental\SurfaceRoughness_0627\result Video\dataBase\40L.mat');

function [lenavg,lenstd,widavg,widstd,ratioavg,ratiostd] = analysisResult(D,indexone,fps)
for k =1:7
    n=1;
    for i= 1:size(indexone,2)
        if indexone(k,i)~=0
            dimesion(k,1,n) = D.shape(indexone(k,i)).Length;
            dimesion(k,2,n) = D.shape(indexone(k,i)).Width;
            dimesion(k,3,n) = D.shape(indexone(k,i)).Ratio;
            n=n+1;
            %if i>20 && i<30
                %figure(i),imshow(uint8(D3.shape(indexone(7,i)).Shape))
            %end
        end
    end
end

for k =1:7
    for n =1:size(dimesion(k,:,:),3)
        s1(1,n)=dimesion(k,1,n);
        s2(1,n)=dimesion(k,2,n);
        s3(1,n)=dimesion(k,3,n);
    end
    lenavg(k)=mean(s1);
    lenstd(k)=std(s1);
    
    widavg(k)=mean(s2);
    widstd(k)=std(s2);
    
    ratioavg(k)=mean(s3);
    ratiostd(k)=std(s3);
    
    figure(k),
    subplot(1,3,1),plot((1:size(s1,2))/fps,s1)
    subplot(1,3,2),plot((1:size(s2,2))/fps,s2)
    subplot(1,3,3),plot((1:size(s3,2))/fps,s3)
end
%% scatter plot
figure,
for k=1:7
    scatter(dimesion(k,1,:),dimesion(k,2,:));hold on
end
figure,scatter([D.shape(1:end).Length],[D.shape(1:end).Width])
%% time series wiht oscillation
figure,plot((1:size([D.shape(1:end).Ratio],2))/fps,[D.shape(1:end).Ratio])
end