% clc,clear
% close all
% clear indexone
% clear D
% D=load('E:\NCKU_experimental\Project_metlpoolDetection\Defects_analysis\keyholeone.mat');
% % net = load('net.mat');
% Length=[D.shape(1:end).Length];
% Width=[D.shape(1:end).Width];
% Ratio = [D.shape(1:end).Ratio];
% inputpp=[Length;Ratio;Width];
% outputs = net(inputpp);
% 
% % View the Network
% view(net)
% 
% % Plots
% % Uncomment these lines to enable various plots.
% figure, plotsomtop(net)
% figure, plotsomnc(net)
% figure, plotsomnd(net)
% figure, plotsomplanes(net)
% figure, plotsomhits(net,inputpp)
% figure, plotsompos(net,inputpp)

%%  fine the  picture index
%first

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
    figure(10+k),imshow(uint8(D.shape(indexone(k,3)).Shape))
    end
end