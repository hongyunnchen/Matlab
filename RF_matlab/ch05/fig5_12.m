%
%   This file computes the bandstop filter response 
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
G=5e-3;   % filter resistance
Zg=50;    % source impedance
ZL=50;    % load imperances

% define frequency range
f_min=10e6;  % lower frequency limit
f_max=100e9; % upper frequency limit
N=100;       % number of points in the graph
f=f_min*((f_max/f_min).^((0:N)/N)); % compute frequency points on log scale
w=2*pi*f;  

H=ZL*(G+1./(j*w*L)+j*w*C)./((ZL+Zg).*(G+1./(j*w*L)+j*w*C)+1);

semilogx(f,-20*log10(abs(H)));
title('Bandstop filter response');
xlabel('Frequency, Hz');
ylabel('Attenuation, dB');

%print -deps 'fig5_12a.eps'  % if uncommented -> saves a copy of plot in EPS format

figure;    % open new graph
phase=atan(imag(H)./real(H));
semilogx(f,phase/pi*180);
title('Bandstop filter response');
xlabel('Frequency, Hz');
ylabel('Phase, deg.');

%print -deps 'fig5_12b.eps'   % if uncommented -> saves a copy of plot in EPS format
