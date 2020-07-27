function [centroid,outputs] = SOMrunning(lengthdata,widthdata,ratiodata)
inputs = [lengthdata;widthdata;ratiodata];
%inputs=[irisInputs];

% Create a Self-Organizing Map
dimension1 = 1;
dimension2 = 7;
net = selforgmap([dimension1 dimension2]);
% Trianing parameter setup
net.trainParam.epochs = 1000;

% Train the Network
[net,tr] = train(net,inputs);

% Test the Network
outputs = net(inputs);
centroid = net.IW
% View the Network
view(net)
end
% Plots
% Uncomment these lines to enable various plots.
% figure, plotsomtop(net)
% figure, plotsomnc(net)
% figure, plotsomnd(net)
% figure, plotsomplanes(net)
% figure, plotsomhits(net,inputs)
% figure, plotsompos(net,inputs)