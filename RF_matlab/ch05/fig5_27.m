%
%   This routine plots a mapping from the normalized to
%   the real frequency for the bandpass filter design with
%   a lower cut-off frequency of 1 and upper cut-off
%   frequency of 3
% 
%   Copyright (c) 1999 by P.Bretchko and R.Ludwig
%   "RF Circuit Design: Theory and Practice"
%

close all; % close all opened graphs
clear all; % clear all variables
figure;    % open new graph

w_L=1; % lower cutoff frequency
w_U=3; % upper cutoff frequency
w_c=sqrt(w_U*w_L); % center frequency
w_real=[-5:0.1:5]; % define frequencies for which the mapping is plotted

% map frequencies
w=w_c/(w_U-w_L).*(w_real/w_c-w_c./w_real);

plot(w_real,w);
axis([-5 5 -2 2]);
title('Mapping of normalized frequency for bandpass filter');
xlabel('Frequency \omega');
ylabel('Normalized frequency \Omega');
grid on;
%print -deps 'fig5_26.eps'


