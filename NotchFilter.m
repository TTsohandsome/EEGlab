function [Y] = NotchFilter(X,Fs,Fa)
% This function is Notch filter function. 
% 
% Input£º
%   X      Raw EEG Data, the data format is [Nchans * Ntime], where Nchans
%   is number of channels (EEG electrodes) and the Ntime is the number of EEG samples
%   Fs     the sampling frequency (in Hz)
%   Fa    Notch target frequency, default 50Hz
% 
% Output£º
%   Y      Notch filtered data 

if nargin == 1
    Fs = 250;
    Fa = 50;
end

if nargin == 2
    Fa = 50;
end

Q = 6; 
Wo = Fa/(Fs/2);  BW = Wo/Q;  
[b,a] = iirnotch(Wo,BW);  
Y = filter(b,a,X')';
end