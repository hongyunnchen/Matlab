%
%   This file computes the attenuation profile of the 
%   Chebyshev filter designed in the Example 5.4
% 
%   Copyright (c) 1999 by P.Bretchko and R.Ludwig
%   "RF Circuit Design: Theory and Practice"
%

clear all; % clear all variables
close all; % close all opened graphs
figure;    % open new graph

%define the frequency range
f_min=1e9;
f_max=4e9;
N=500;
f=f_min:(f_max-f_min)/(N-1):f_max;
w=2*pi*f;

% define problem parameters
fc=2.4e9; % center frequency
delta=0.1; % passband width

fl=(1-delta)*fc; % lower cutoff frequency
fu=(1+delta)*fc; % upper cutoff frequency
BW=2*pi*(fu-fl); % bandwidth
w0=2*pi*sqrt(fl*fu);

% low-pass filter prototype parameters
g0=1;
g1=3.3487;
g2=0.7117;
g3=3.3487;
g4=1;

% set generator impedance
Rg=50;


% perform scaling to take into account generator resistance
LL1=g1*Rg
CC2=g2/Rg
LL3=g3*Rg
RL=g4*Rg;

% frequency scaling
L1=LL1/BW
C1=BW/w0^2/LL1

L2=BW/w0^2/CC2
C2=CC2/BW

L3=L1
C3=C1


% compute the frequency response
Z=RL;
Z=Z+j*w*L3+1./(j*w*C3);
Z=1./(1./Z+1./(j*w*L2)+j*w*C2);
Z=Z+j*w*L1+1./(j*w*C1);

Gamma=(Z-Rg)./(Z+Rg);
LF=1-abs(Gamma).^2;

plot(f/1e9,-10*log10(LF));
axis([f_min/1e9 f_max/1e9 0 70]);
title('Attenuation of the bandpass 3dB Chebyshev filter designed in Example 5.4');
xlabel('Frequency, GHz');
ylabel('Attenuation, dB');

%print -deps 'fig5_30.eps'

