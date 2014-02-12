%
%   This program generates an impedance transformation 
%   plot in the Smith Chart described in Example 8-6
% 
%   Copyright (c) 1999 by P.Bretchko and R.Ludwig
%   "RF Circuit Design: Theory and Practice"
%

close all; % close all opened graphs
clear all; % clear all variables

set_Z0(50); % set characteristic line impedance to 50 Ohm

% define load impedances
ZL=10-j*10;

f0=2.4e9;

% create Smith Chart
sm=smith_chart;
% plot Qn=2 contour
Qn_contours(2,sm);
text(0.35,0.6,'\bfQ_n=2');
text(0.35,-0.63,'\bfQ_n=2');

global rf_Network; % define a global variable to store the network description

% define a matching network
L1=1.31e-9;
C2=1.65e-12;
L3=1.66e-9;
init_network; % initialize network description
Add_shunt_impedance(ZL);
Add_shunt_inductor(L1);
Add_series_capacitor(C2);
Add_shunt_inductor(L3);
Zin=rf_imp_transform(f0,sm)

text(-0.72, -0.22,'\bfz_L');
text(-0.5, 0.08,'\bfA');
text(-0.12, -0.5,'\bfB');
text(-0.12, 0.7,'\bfz_{in}');

% print -deps 'fig8_17.eps'

