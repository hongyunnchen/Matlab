%
%   Computation of attenuation profile for the lowpass filter obtained
%   from the lowpass 3dB Chebyshev prototype
% 
%   Copyright (c) 1999 by P.Bretchko and R.Ludwig
%   "RF Circuit Design: Theory and Practice"
%

close all; % close all opened graphs
clear all; % clear all variables
figure;    % open new graph

%lowpass filter w_real=w*w_c
w_c=2*pi*1e9;  % pick angular cut-off frequency for f=1GHz
w_real=(0:0.01:2)*w_c;

w=w_real/w_c;
IL=10*log10(1+(1-8*w.^2+8*w.^4).^2);

plot(w_real/(2*pi)/1e9,IL);
axis([0 2 0 30]);
title('Attenuation profile of 3dB Chebyshev lowpass filter with 1GHz cut-off frequency');
xlabel('Frequency {\itf}, GHz');
ylabel('Attenuation, dB');
%print -deps 'fig5_25.eps'

