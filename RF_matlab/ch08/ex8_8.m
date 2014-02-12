%
%   This program generates an impedance transformation 
%   plot in the Smith Chart as described in Example 8-8
% 
%   Copyright (c) 1999 by P.Bretchko and R.Ludwig
%   "RF Circuit Design: Theory and Practice"
%

close all; % close all opened graphs
clear all; % clear all variables

global Z0;
set_Z0(75); % set characteristic line impedance to 50 Ohm

% define load impedances
ZL=60-j*45;
Zin=75+j*90;

f=1e9; % no frequency is necessary to solve this example.
       % However, we need a frequency reference in the impedance transformations
       % For this reason the value is arbitrarily set to f=1GHz

% create Smith Chart
sm=smith_chart;

const_SWR_circle(Zin,'m--');
const_G_circle(real(1/ZL),'m--');

global rf_Network; % define a global variable to store the network description

% define a matching network A
l_SA=0.067; 
l_LA=0.266;
init_network; % initialize network description
Add_shunt_impedance(ZL);
Add_shunt_oc_stub(360*l_SA,f,Z0);
Add_trans_line(360*l_LA,f,Z0);
Zin_A=rf_imp_transform(f,sm)

% define a matching network B
l_SB=0.087;
l_LB=0.07;
init_network; % initialize network description
Add_shunt_impedance(ZL);
Add_shunt_sc_stub(360*l_SB,f,Z0);
Add_trans_line(360*l_LB,f,Z0);
Zin_A=rf_imp_transform(f,sm)

text( 0.06, -0.36,'\bfz_L');
text(-0.19, -0.54,'\bfA');
text(-0.20,  0.57,'\bfB');
text( 0.32,  0.46,'\bfz_{in}');

% print -deps 'fig8_24.eps'

