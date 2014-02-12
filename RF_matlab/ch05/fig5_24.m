%
%   Computation of the attenuation profile for the lowpass
%   3dB Chebyshev filter prototype of 4th order
% 
%   Copyright (c) 1999 by P.Bretchko and R.Ludwig
%   "RF Circuit Design: Theory and Practice"
%

close all; % close all opened graphs
clear all; % clear all variables
figure;    % open new graph

% define normalized frequency range
w=-1.5:0.01:1.5;

% specify lowpass filter prototype
IL=10*log10(1+(1-8*w.^2+8*w.^4).^2);

plot(w,IL);
axis([-2 2 0 30]);
title('Attenuation profile of 4^{th} order 3dB Chebyshev lowpass filter prototype');
xlabel('Normalized frequency \Omega');
ylabel('Attenuation, dB');
%print -deps 'fig5_24.eps'
