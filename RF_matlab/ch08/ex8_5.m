%
%   This program generates an impedance transformation 
%   plot and displays it inside the Smith Chart
% 
%   Copyright (c) 1999 by P.Bretchko and R.Ludwig
%   "RF Circuit Design: Theory and Practice"
%

close all; % close all opened graphs
clear all; % clear all variables

set_Z0(50); % set characteristic line impedance to 50 Ohm

% define load impedances
ZL=60-j*30;

f0=1e9;

% create Smith Chart
sm=smith_chart;
% plot Qn=3 contour
Qn_contours(3,sm);
text(-0.05,0.8,'\bfQ_n=3');
text(-0.05,-0.8,'\bfQ_n=3');

global rf_Network; % define a global variable and store the network description

% define a matching network
C1=8.72e-12;
C2=3.53e-12;
L3=7.85e-9;
init_network; % initialize the network description
Add_shunt_impedance(ZL);
Add_series_capacitor(C1);
Add_shunt_capacitor(C2);
Add_series_inductor(L3);
Zin=rf_imp_transform(f0,sm)

text(0.15, -0.15,'\bfz_L');
text(0.3, -0.33,'\bfA');
text(-0.35, -0.58,'\bfB');
text(-0.44, 0.53,'\bfz_{in}');

% print -deps 'fig8_15.eps'

