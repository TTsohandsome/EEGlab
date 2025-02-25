function filterdata=filter_param(data,low,high,sampleRate,filterorder)
% Filter data
% Input£º
%   data                the raw EEG data to be filtered
%   low                 High pass filtering parameter settings
%   high                Low pass filtering parameter settings
%   sampleRate          the sampling frequency (in Hz)
%   filterorder         butterworth filter order
% Output£º
%   filterdata          the filtered EEG data

% set para
filtercutoff = [low*2/sampleRate high*2/sampleRate];  
[filterParamB, filterParamA] = butter(filterorder,filtercutoff); 
filterdata= filter( filterParamB, filterParamA, data);
end