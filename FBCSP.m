function [fbcspfeature,fbcspw] = FBCSP(eeg,label,m,bands,fs,filterorder)
% Call the function FBCSP, perform CSP for each frequency band in the bands, and then concatenate features
% eeg:Segmented 3D EEG (filtered), sampling points * channels * number of experiments
% label£ºThe label of EEG, column vector, and values are only 1 and 2
% m£ºcsp para
% bands:Different frequency bands£¬example [1 4;4 7;8 13]
% fs:the sampling frequency (in Hz)
% filterorder:filter order

% fbcspfeature:extracted the fbcsp feature
% fbcspw:fbcsp filter

fbcspfeature = [];
fbcspw=[];

for i = 1:size(bands,1)
    udfilter=designfilt('bandpassiir','FilterOrder',filterorder, ...
    'HalfPowerFrequency1',bands(i,1),'HalfPowerFrequency2',bands(i,2), ...
    'SampleRate',fs);
    filtedeeg = zeros(size(eeg));
    for trial = 1:size(eeg,3)
        for ch = 1:size(eeg,2)
            filtedeeg(:,ch,trial)=filter(udfilter,eeg(:,ch,trial));
        end
    end

    [cspfeature, cspw] = CSP(filtedeeg,label,m);

    fbcspfeature = cat(2,fbcspfeature,cspfeature);

    fbcspw = cat(3,fbcspw,cspw);

end

end


