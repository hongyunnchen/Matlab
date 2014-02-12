%
%   This program compares the saturation drain current
%   of a FET computed by using the exact formula versus 
%   the quadratic law approximation
% 
%   Copyright (c) 1999 by P.Bretchko and R.Ludwig
%   "RF Circuit Design: Theory and Practice"
%

close all; % close all opened graphs
clear all; % clear all variables
figure;    % open new graph

% define problem parameters
Nd=1e16*1e6;
d=0.75e-6;
W=10e-6;
L=2e-6;
eps_r=12;
Vd=0.8;
mu_n=8500e-4;
Vgs=0:-0.01:-4;

% define physical constants
q=1.60218e-19; % electron charge
eps0=8.85e-12; % permittivity of free space

eps=eps_r*eps0;

% pinch-off voltage
Vp=q*Nd*d^2/(2*eps)

% threshold voltage
Vt0=Vd-Vp

% conductivity of the channel
sigma=q*mu_n*Nd

% channel conductance
G0=q*sigma*Nd*W*d/L

% saturation current using the exact formula
Id_sat=G0*(Vp/3-(Vd-Vgs)+2/(3*sqrt(Vp))*(Vd-Vgs).^(3/2)).*(1-(Vgs<Vt0));
Idss=Id_sat(1) % saturation current at Vgs=0

% saturation current using the quadratic law approximation
Id_sat_square=Idss*(1-Vgs/Vt0).^2.*(1-(Vgs<Vt0));

plot(Vgs,Id_sat,Vgs,Id_sat_square);
legend('exact formula', 'quadratic approximation',2);
title('FET saturation current as a function of the gate-source voltage');
xlabel('Gate-source voltage V_{GS}, V');
ylabel('Drain saturation current I_{DSat}, A');

%print -deps 'fig6_42.eps'
