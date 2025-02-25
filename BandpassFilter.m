function [Y] = BandpassFilter(X,Fs,Fl,Fh,N,type)
% This function is BandPass Filter function.
% 
% Input£º
%   X:      Raw EEG Data, the data format is [Nchans * Ntime], where Nchans
%   is number of channels (EEG electrodes) and the Ntime is the number of EEG samples
%   Fs:     the sampling frequency (in Hz)
%   Fbp:    [Fhp Flp], the range of frequency.
%   N:      filter order,  default 4 (but) or 25 (fir) 
%   type:   filter type
%             'but' Butterworth IIR filter (default)
%             'fir' FIR filter using Matlab fir1 function 
%
% Output£º
%   Y:      The filtered data.


if nargin<2
    Fs = 250;
end

if nargin<4
    Fl = 0.5;
    Fh = 50;
end

% set the default filter order later
if nargin<5
    N = [];
end

% set the default filter type
if nargin<5
  type = 'but';
end

% Nyquist frequency
Fn = Fs/2;

Fbp = [Fl Fh];

% X = X-detrend(X);

% compute filter coefficients and apply the filter to the data
switch type
  case 'but'
    if isempty(N)
      N = 2;
    end
    if((Fl+Fh)/2==31.2)
         [B, A] = butter(N, [min(Fbp)/Fn max(Fbp)/Fn],'stop');
    else
        [B, A] = butter(N, [min(Fbp)/Fn max(Fbp)/Fn]);
    end
   
  case 'fir'
    if isempty(N)
      N = 25;
    end
    [B, A] = fir1(N, [min(Fbp)/Fn max(Fbp)/Fn]);
end

Y = filter(B, A, X')';


