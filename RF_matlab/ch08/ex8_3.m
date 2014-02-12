%
%   This program generates a Smith Chart plot for Example 8.3
% 
%   Copyright (c) 1999 by P.Bretchko and R.Ludwig
%   "RF Circuit Design: Theory and Practice"
%

close all; % close all opened graphs
clear all; % clear all variables

set_Z0(50); % set characteristic line impedance to 50 Ohm

% specify load and source impedances
ZL=25-j*50;
ZS=50+j*25;

YL=1/ZL;
YS=1/ZS;

fig_num=Smith_Chart;  % open new graph
const_R_circle(real(ZL),'c--');
const_G_circle(real(YL),'c--');
const_R_circle(real(ZS),'m--');
const_G_circle(real(YS),'m--');

global rf_Network; % define a global variable to store a network description

% circuit A
L1=1.59e-9;
L2=6.63e-9;
init_network; % initialize network description
Add_shunt_impedance(ZS);
Add_shunt_inductor(L2);
Add_series_inductor(L1);
rf_imp_transform(2e9,fig_num);

% circuit B
L=6.37e-9;
C=2.23e-12;
init_network; % initialize network description
Add_shunt_impedance(ZS);
Add_shunt_capacitor(C);
Add_series_inductor(L);
rf_imp_transform(2e9,fig_num);

% circuit C
L=3.06e-9;
C=0.94e-12;
init_network; % initialize network description
Add_shunt_impedance(ZS);
Add_series_capacitor(C);
Add_shunt_inductor(L);
rf_imp_transform(2e9,fig_num);

% circuit D
L1=2.79e-9;
L2=13.26e-9;
init_network; % initialize network description
Add_shunt_impedance(ZS);
Add_series_inductor(L1);
Add_shunt_inductor(L2);
rf_imp_transform(2e9,fig_num);

text(0.07,0.73,'\bfz_{L}^{*}');
text(0.12,0.25,'\bfz_{S}');
text(-0.18,0.54,'\bfA');
text(-0.18,-0.54,'\bfB');
text(0.25,-0.51,'\bfC');
text(0.25,0.51,'\bfD');

