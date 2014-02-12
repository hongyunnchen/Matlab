%
%   This program computes the capacitance of the pn-junction
%   as a function of the applied voltage
% 
%   Copyright (c) 1999 by P.Bretchko and R.Ludwig
%   "RF Circuit Design: Theory and Practice"
%

close all; % close all opened graphs
clear all; % clear all variables
figure;    % open new graph

% define problem parameters
ni=1.5e10; % intrinsic carrier concentration in Si
Na=1e15;   % acceptor doping concentration
Nd=5e15;   % donor concentration
A=1e-4;    % cross sectional area
eps_r=11.9; % dielectric constant of Si

% define physical constants
q=1.60218e-19; % electron charge
k=1.38066e-23; % Boltzmann's constant
eps0=8.85e-12; % permittivity of free space

eps=eps_r*eps0;

T=300; % temperature

% compute diffusion barrier voltage
Vdiff=k*T/q*log(Na*Nd/ni^2)

% junction capacitance at zero applied voltage
C0=A*sqrt(q*eps/(1/Na+1/Nd)/2/Vdiff)

% extents of the space charge region
dn=sqrt(2*eps*Vdiff/q*Na/Nd/(Na+Nd)) % in n-semiconductor 
dp=sqrt(2*eps*Vdiff/q*Nd/Na/(Na+Nd)) % in p-semiconductor

% define range for applied voltage
VA=-5:0.1:Vdiff;

% compute junction capacitance
C=C0*(1-VA/Vdiff).^(-1/2);

plot(VA,C/1e-12);
title('Junction capacitance of abrupt Si pn-contact');
xlabel('Applied junction voltage V_A, Volts');
ylabel('Junction capacitance C, pF');
%print -deps 'fig6_7.eps'