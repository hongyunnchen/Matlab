%
%   This file computes various quality factors and
%   generates the graph for Example 5.2
% 
%   Copyright (c) 1999 by P.Bretchko and R.Ludwig
%   "RF Circuit Design: Theory and Practice"
%

clear all; % clear all variables
close all; % close all opened graphs
figure;    % open new graph

% define problem parameters
Z0=50;    % characteristic line impedance
ZG=50;    % source impedance
ZL=50;    % load imperances

% series RLC filter parameters
R=10;
L=50e-9;
C=0.47e-12;

% generator voltage
VG=5;

% compute series resonance frequency
w0=1/sqrt(L*C)
f0=w0/(2*pi)

% define a frequency range
delta=0.2;  % frequency range
w=((1-delta):2*delta/1000:(1+delta))*w0;

% compute quality factors
Q_LD=w0*L/(R+2*ZL) % loaded quality factor
Q_F=w0*L/R         % internal or filter quality factor 
Q_E=w0*L/(2*ZL)    % external quality factor

% find a bandwidth
BW=f0/Q_LD

% compute input and load powers
P_in=VG^2/(4*Z0)
P_L=P_in*Q_LD^2/Q_E^2

% compute insertion loss and load factor
epsilon=w/w0-w0./w;
LF=(1+epsilon.^2*Q_LD^2)/(1-Q_LD/Q_F)^2; 
IL=10*log10(LF);

plot(w/2/pi/1e9,IL);
title('Insertion loss versus frequency');
xlabel('Frequency, GHz');
ylabel('Insertion loss, dB');
% print -deps 'fig5_15.eps'    % if uncommented -> saves a copy of plot in EPS format
