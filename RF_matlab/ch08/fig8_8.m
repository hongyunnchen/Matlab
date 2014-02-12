%
%   This program generates an impedance transformation
%   plot for the circuits shown in Figure 8-8 (b) and (c)
% 
%   Copyright (c) 1999 by P.Bretchko and R.Ludwig
%   "RF Circuit Design: Theory and Practice"
%

close all; % close all opened graphs
clear all; % clear all variables

set_Z0(50); % set characteristic line impedance to 50 Ohm

f=1e9;
w=2*pi*f;
% specify load and source impedances
RL=80;
CL=2.65e-12;
ZL=RL+1/(j*w*CL);
ZS=50;

YL=1/ZL;
YS=1/ZS;

fig_num=Smith_Chart;  % open a new graph
const_G_circle(real(YL),'m--');
const_R_circle(real(ZS),'m--');

global rf_Network; % define a global variable to store the network description

% circuit B
L=10.1e-9;
C=2.6e-12;
init_network; % initialize network description
Add_shunt_impedance(ZL);
Add_shunt_inductor(L);
Add_series_capacitor(C);
rf_imp_transform(f,fig_num);

% circuit C
L=9.75e-9;
C=0.6e-12;
init_network; % initialize network description
Add_shunt_impedance(ZL);
Add_shunt_capacitor(C);
Add_series_inductor(L);
rf_imp_transform(f,fig_num);

text(0.42,-0.26,'\bfz_{L}');
text(0.05,0.05,'\bfz_{S}');
text(0.26,0.52,'\bfA');
text(0.26,-0.53,'\bfB');

