% detect the other samples detection
clear
clc
files = {'1.mat','2.mat','3.mat',...
          '4.mat','5.mat','6.mat',...
          '7.mat','8.mat','9.mat',...
          '10.mat',...
          '11.mat','12.mat','13.mat',...
          '14.mat','15.mat','16.mat',...
          '17.mat','18.mat','19.mat',...
          '20.mat','21.mat','22.mat','23.mat','24.mat'};
% files = {'1.mat','2.mat'};
centromatrix = zeros(numel(files),7,3); % record the all of the centorid

for i = 1:numel(files)
    %% post-pocessing 
    % for each files load and setup
    Data = load(files{i});
    leng(1,1:size([Data.shape(1:end)],2))= [Data.shape(1:end).Length];
    width(1,1:size([Data.shape(1:end)],2))= [Data.shape(1:end).Width];
    ratio(1,1:size([Data.shape(1:end)],2))= [Data.shape(1:end).Ratio];
    
   n=1;
   for k = 1:size(leng,1)
       for j = 1:size(leng,2)
           if leng(k,j)~=0
               lengthdata(n)=leng(k,j);
               n= n+1;
           end
       end
   end
   
   n=1;
   for k = 1:size(width,1)
       for j = 1:size(width,2)
           if width(k,j)~=0
               widthdata(n)=width(k,j);
               n= n+1;
           end
       end
   end
   
   n=1;
   for k = 1:size(ratio,1)
       for j = 1:size(ratio,2)
           if ratio(k,j)~=0
               ratiodata(n)=ratio(k,j);
               n= n+1;
           end
       end
   end
   %% Self-organize map running
   [centroid,outputs] = SOMrunning(lengthdata,widthdata,ratiodata);
   centromatrix(i,:,:) = centroid{1,1}; %centroid is a cell not a matix
   %% result check
   % Identify the index of cluster
   for k = 1:7 %the number of class
       n =1;
       for j = 1:size(outputs,2)
           if outputs(k,j)~=0
               indexone(k,n) = j;
               n =n+1;
           end
       end
   end
%    
%    for k =1:7
%        if indexone(k,3)~=0
%            figure(10+k),imshow(uint8(Data.shape(indexone(k,3)).Shape))
%        end
%    end
%   [lenavg,lenstd,widavg,widstd,ratioavg,ratiostd] = analysisResult(Data,indexone,4000);
end

ccmatrix=zeros(7*numel(files),3);
n=1;
for i = 1:numel(files)
    for k = 1:7
        ccmatrix(n,:) = centromatrix(i,k,:);
        n=n+1;
    end
end
xlswrite('combimematrix.xlsx',ccmatrix);        



