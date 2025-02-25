function [Y] = FFT2(X, Fs)
% fft2 Fourier transform algorithm
%   Input£º X £ºInput data matrix, the data format is [Ntime*Nchans], where Nchans
%   is number of channels (EEG electrodes) and the Ntime is the number of EEG samples
%           Fs£º the sampling frequency (in Hz)
%   Output£º y: Data after Fast Fourier Transform

if nargin < 2 
    Fs=250;
end

Ntime = size(X,1);  
Nchans = size(X,2);  

% FFT
for i = 1:Nchans
    x_each_channel=X(:,i);
    x_each_channel=x_each_channel-mean(x_each_channel); 
    z=fft(x_each_channel);
    
 
    f=(0:Ntime-1)*Fs/Ntime;
    Mag=2*abs(z)/Ntime;   
    Pyy=Mag.^2;         

    Y(:,i) = Mag;
end
end

