%
%   This file generates the graph for Example 5.1
%   "Band pass filter response" 
% 
%   Copyright (c) 1999 by P.Bretchko and R.Ludwig
%   "RF Circuit Design: Theory and Practice"
%

close all; % close all opened graphs
clear all; % clear all variables
figure;    % open new graph

% define problem parameters
C=2e-12;  % filter capacitance
L=5e-9;   % filter inductance
R=20;     % filter resistance
Zg=50;    % source impedance
ZL=50;    % load imperances

% define frequency range
f_min=1e6;  % lower frequency limit
f_max=10e9; % upper frequency limit
N=100;      % number of points in the graph
f=f_min*((f_max/f_min).^((0:N)/N)); % compute frequency points on log scale
w=2*pi*f;  

H=ZL./(ZL+Zg+R+(1./(j*w*C)+j*w*L));

semilogx(f,-20*log10(abs(H)));
title('Bandpass filter response');
xlabel('Frequency, Hz');
ylabel('Attenuation, dB');

%print -deps 'fig5_11a.eps'     % if uncommented -> saves a copy of plot in EPS format

figure;    % open new graph
phase=atan(imag(H)./real(H));
semilogx(f,phase/pi*180);
title('Bandpass filter response');
xlabel('Frequency, Hz');
ylabel('Phase, deg.');

%print -deps 'fig5_11b.eps'     % if uncommented -> saves a copy of plot in EPS format


