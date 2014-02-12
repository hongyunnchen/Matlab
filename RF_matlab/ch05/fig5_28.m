%
%   Computation of attenuation profile for the bandpass filter obtained
%   from the lowpass 3dB Chebyshev prototype
% 
%   Copyright (c) 1999 by P.Bretchko and R.Ludwig
%   "RF Circuit Design: Theory and Practice"
%

close all; % close all opened graphs
clear all; % clear all variables
figure;    % open new graph

%bandpass filter
w_U=1.3e9*(2*pi);  % upper cut-off frequency of 1.3GHz
w_L=0.7e9*(2*pi);  % lower cut-off frequency of 0.7GHz
w_c=sqrt(w_U*w_L); % center frequency
w_real=(0.01:0.01:2)*w_c;

w=w_c./(w_U-w_L).*(w_real/w_c-w_c./w_real);
IL=10*log10(1+(1-8*w.^2+8*w.^4).^2);

plot(w_real/(2*pi)/1e9,IL);
axis([0 2 0 30]);
title('Attenuation of 3dB Chebyshev bandpass filter');
xlabel('Frequency {\itf}, GHz');
ylabel('Attenuation, dB');
%print -deps 'fig5_28.eps'


