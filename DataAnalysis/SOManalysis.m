% SOM analysis
% Date:2020/07/06
% @CastroLin

clc,clear
close all
%% Import data file and 
Data = load('E:\NCKU_experimental\Project_metlpoolDetection\Defects_analysis\keyholetwo.mat');
% leng =zeros(24,10000000);
% width =zeros(24,10000000);
% ratio =zeros(24,10000000);
%% Length 
leng(1,1:size([Data.shape(1:end).Length],2)) = [Data.shape(1:end).Length];
% leng(1,1:size([Data.D1.shape(1:end).Length],2)) = [Data.D1.shape(1:end).Length];
% leng(2,1:size([Data.D2.shape(1:end).Length],2)) = [Data.D2.shape(1:end).Length];
% leng(3,1:size([Data.D3.shape(1:end).Length],2)) = [Data.D3.shape(1:end).Length];
% leng(4,1:size([Data.D4.shape(1:end).Length],2)) = [Data.D4.shape(1:end).Length];
% leng(5,1:size([Data.D5.shape(1:end).Length],2)) = [Data.D5.shape(1:end).Length];
% leng(6,1:size([Data.D6.shape(1:end).Length],2)) = [Data.D6.shape(1:end).Length];
% leng(7,1:size([Data.D7.shape(1:end).Length],2)) = [Data.D7.shape(1:end).Length];
% leng(8,1:size([Data.D8.shape(1:end).Length],2)) = [Data.D8.shape(1:end).Length];
% leng(9,1:size([Data.D9.shape(1:end).Length],2)) = [Data.D9.shape(1:end).Length];
% leng(10,1:size([Data.D10.shape(1:end).Length],2)) = [Data.D10.shape(1:end).Length];
% leng(11,1:size([Data.D11.shape(1:end).Length],2)) = [Data.D11.shape(1:end).Length];
% leng(12,1:size([Data.D12.shape(1:end).Length],2)) = [Data.D12.shape(1:end).Length];
% leng(13,1:size([Data.D13.shape(1:end).Length],2)) = [Data.D13.shape(1:end).Length];
% leng(14,1:size([Data.D14.shape(1:end).Length],2)) = [Data.D14.shape(1:end).Length];
% leng(15,1:size([Data.D15.shape(1:end).Length],2)) = [Data.D15.shape(1:end).Length];
% leng(16,1:size([Data.D16.shape(1:end).Length],2)) = [Data.D16.shape(1:end).Length];
% leng(17,1:size([Data.D17.shape(1:end).Length],2)) = [Data.D17.shape(1:end).Length];
% leng(18,1:size([Data.D18.shape(1:end).Length],2)) = [Data.D18.shape(1:end).Length];
% leng(19,1:size([Data.D19.shape(1:end).Length],2)) = [Data.D19.shape(1:end).Length];
% leng(20,1:size([Data.D20.shape(1:end).Length],2)) = [Data.D20.shape(1:end).Length];
% leng(21,1:size([Data.D21.shape(1:end).Length],2)) = [Data.D21.shape(1:end).Length];
% leng(22,1:size([Data.D22.shape(1:end).Length],2)) = [Data.D22.shape(1:end).Length];
% leng(23,1:size([Data.D23.shape(1:end).Length],2)) = [Data.D23.shape(1:end).Length];
% leng(24,1:size([Data.D24.shape(1:end).Length],2)) = [Data.D24.shape(1:end).Length];
%% width
width(1,1:size([Data.shape(1:end)],2)) = [Data.shape(1:end).Width];
% width(1,1:size([Data.D1.shape(1:end).Width],2)) = [Data.D1.shape(1:end).Width];
% width(2,1:size([Data.D2.shape(1:end).Width],2)) = [Data.D2.shape(1:end).Width];
% width(3,1:size([Data.D3.shape(1:end).Width],2)) = [Data.D3.shape(1:end).Width];
% width(4,1:size([Data.D4.shape(1:end).Width],2)) = [Data.D4.shape(1:end).Width];
% width(5,1:size([Data.D5.shape(1:end).Width],2)) = [Data.D5.shape(1:end).Width];
% width(6,1:size([Data.D6.shape(1:end).Width],2)) = [Data.D6.shape(1:end).Width];
% width(7,1:size([Data.D7.shape(1:end).Width],2)) = [Data.D7.shape(1:end).Width];
% width(8,1:size([Data.D8.shape(1:end).Width],2)) = [Data.D8.shape(1:end).Width];
% width(9,1:size([Data.D9.shape(1:end).Width],2)) = [Data.D9.shape(1:end).Width];
% width(10,1:size([Data.D10.shape(1:end).Width],2)) = [Data.D10.shape(1:end).Width];
% width(11,1:size([Data.D11.shape(1:end).Width],2)) = [Data.D11.shape(1:end).Width];
% width(12,1:size([Data.D12.shape(1:end).Width],2)) = [Data.D12.shape(1:end).Width];
% width(13,1:size([Data.D13.shape(1:end).Width],2)) = [Data.D13.shape(1:end).Width];
% width(14,1:size([Data.D14.shape(1:end).Width],2)) = [Data.D14.shape(1:end).Width];
% width(15,1:size([Data.D15.shape(1:end).Width],2)) = [Data.D15.shape(1:end).Width];
% width(16,1:size([Data.D16.shape(1:end).Width],2)) = [Data.D16.shape(1:end).Width];
% width(17,1:size([Data.D17.shape(1:end).Width],2)) = [Data.D17.shape(1:end).Width];
% width(18,1:size([Data.D18.shape(1:end).Width],2)) = [Data.D18.shape(1:end).Width];
% width(19,1:size([Data.D19.shape(1:end).Width],2)) = [Data.D19.shape(1:end).Width];
% width(20,1:size([Data.D20.shape(1:end).Width],2)) = [Data.D20.shape(1:end).Width];
% width(21,1:size([Data.D21.shape(1:end).Width],2)) = [Data.D21.shape(1:end).Width];
% width(22,1:size([Data.D22.shape(1:end).Width],2)) = [Data.D22.shape(1:end).Width];
% width(23,1:size([Data.D23.shape(1:end).Width],2)) = [Data.D23.shape(1:end).Width];
% width(24,1:size([Data.D24.shape(1:end).Width],2)) = [Data.D24.shape(1:end).Width];
%%  Ratio
ratio(1,1:size([Data.shape(1:end).Ratio],2)) = [Data.shape(1:end).Ratio];
% ratio(1,1:size([Data.D1.shape(1:end).Ratio],2)) = [Data.D1.shape(1:end).Ratio];
% ratio(2,1:size([Data.D2.shape(1:end).Ratio],2)) = [Data.D2.shape(1:end).Ratio];
% ratio(3,1:size([Data.D3.shape(1:end).Ratio],2)) = [Data.D3.shape(1:end).Ratio];
% ratio(4,1:size([Data.D4.shape(1:end).Ratio],2)) = [Data.D4.shape(1:end).Ratio];
% ratio(5,1:size([Data.D5.shape(1:end).Ratio],2)) = [Data.D5.shape(1:end).Ratio];
% ratio(6,1:size([Data.D6.shape(1:end).Ratio],2)) = [Data.D6.shape(1:end).Ratio];
% ratio(7,1:size([Data.D7.shape(1:end).Ratio],2)) = [Data.D7.shape(1:end).Ratio];
% ratio(8,1:size([Data.D8.shape(1:end).Ratio],2)) = [Data.D8.shape(1:end).Ratio];
% ratio(9,1:size([Data.D9.shape(1:end).Ratio],2)) = [Data.D9.shape(1:end).Ratio];
% ratio(10,1:size([Data.D10.shape(1:end).Ratio],2)) = [Data.D10.shape(1:end).Ratio];
% ratio(11,1:size([Data.D11.shape(1:end).Ratio],2)) = [Data.D11.shape(1:end).Ratio];
% ratio(12,1:size([Data.D12.shape(1:end).Ratio],2)) = [Data.D12.shape(1:end).Ratio];
% ratio(13,1:size([Data.D13.shape(1:end).Ratio],2)) = [Data.D13.shape(1:end).Ratio];
% ratio(14,1:size([Data.D14.shape(1:end).Ratio],2)) = [Data.D14.shape(1:end).Ratio];
% ratio(15,1:size([Data.D15.shape(1:end).Ratio],2)) = [Data.D15.shape(1:end).Ratio];
% ratio(16,1:size([Data.D16.shape(1:end).Ratio],2)) = [Data.D16.shape(1:end).Ratio];
% ratio(17,1:size([Data.D17.shape(1:end).Ratio],2)) = [Data.D17.shape(1:end).Ratio];
% ratio(18,1:size([Data.D18.shape(1:end).Ratio],2)) = [Data.D18.shape(1:end).Ratio];
% ratio(19,1:size([Data.D19.shape(1:end).Ratio],2)) = [Data.D19.shape(1:end).Ratio];
% ratio(20,1:size([Data.D20.shape(1:end).Ratio],2)) = [Data.D20.shape(1:end).Ratio];
% ratio(21,1:size([Data.D21.shape(1:end).Ratio],2)) = [Data.D21.shape(1:end).Ratio];
% ratio(22,1:size([Data.D22.shape(1:end).Ratio],2)) = [Data.D22.shape(1:end).Ratio];
% ratio(23,1:size([Data.D23.shape(1:end).Ratio],2)) = [Data.D23.shape(1:end).Ratio];
% ratio(24,1:size([Data.D24.shape(1:end).Ratio],2)) = [Data.D24.shape(1:end).Ratio];

%%  data matrix
%clear Data
n=1;
for i =1:size(leng,1)
    for j = 1:size(leng,2)
        if leng(i,j)~=0
            lengthdata(n)=leng(i,j);
            n=n+1;
        end
    end
end
n=1;
for i =1:size(width,1)
    for j = 1:size(width,2)
        if width(i,j)~=0
            widthdata(n)=width(i,j);
            n=n+1;
        end
    end
end
n=1;
for i =1:size(ratio,1)
    for j = 1:size(ratio,2)
        if ratio(i,j)~=0
            ratiodata(n)=ratio(i,j);
            n=n+1;
        end
    end
end

[centroid,outputs] = SOMrunning(lengthdata,widthdata,ratiodata);

%% Result check
for k=1:7
    n=1;
    for j =1:size(outputs,2)
        if outputs(k,j) ~=0
            indexone(k,n) = j;
            n=n+1;
        end
    end
end

for k =1:7
    if indexone(k,3)~=0
    figure(10+k),imshow(uint8(Data.shape(indexone(k,3)).Shape))
    end
end

[lenavg,lenstd,widavg,widstd,ratioavg,ratiostd] = analysisResult(Data,indexone,4000);










