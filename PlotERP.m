function PlotERP(data,label,lower,higher,sampleRate,butterOrder,smoothPara)
channel = [1:17, 19:30];
MIEEGData = data;
trigger = find(MIEEGData(:,33)==2);

EEG = zeros(2500,29,40);

for i = 1:length(trigger)
    EEG(:,:,i) = MIEEGData(trigger(i)-500:trigger(i)-500+2499,channel);
end

h = figure;
set(h,'position',[100 100 300 400]);
plotERDERS(EEG,label,lower,higher,sampleRate,butterOrder,smoothPara);
end

