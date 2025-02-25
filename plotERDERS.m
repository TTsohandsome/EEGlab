function plotERDERS(datar1,labelr1,lower,higher,sampleRate,butterOrder,smoothPara)
%input datar1:3D event EEG data, data format:[sample points*channels* trials]
%     labelr1:datar1 label
%       lower:High pass filtering parameter settings
%      higher:Low pass filtering parameter settings
%  sampleRate:the sampling frequency (in Hz)
% butterOrder:Filter order
%  smoothPara:Smoothing coefficient
%
% output figure:ERD/ERS image
dataleft=[];   
dataright=[];                             
k=1;
n=1;
for i=1:size(datar1,3)       
    if labelr1(i)==1     % left hand
        dataleft(:,:,k)=datar1(:,:,i);
        k=k+1;
    elseif labelr1(i)==2 % right hand
        dataright(:,:,n)=datar1(:,:,i);
        n=n+1;
    end
end

subplot(2,1,1)
PlotEvent(dataleft,lower,higher,sampleRate,butterOrder,smoothPara);      
title('MI with Left Hand','FontSize', 12);

subplot(2,1,2)
PlotEvent(dataright,lower,higher,sampleRate,butterOrder,smoothPara); 
title('MI with Right Hand','FontSize', 12);
