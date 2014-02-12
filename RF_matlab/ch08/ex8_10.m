%
%   This program generates impedance transformation 
%   plot for double-stub tuner design
% 
%   Copyright (c) 1999 by P.Bretchko and R.Ludwig
%   "RF Circuit Design: Theory and Practice"
%

close all; % close all opened graphs
clear all; % clear all variables

global Z0;
set_Z0(50); % set characteristic line impedance to 50 Ohm

% define load impedances
ZL=50+j*50;

% create Smith Chart
sm=smith_chart;

% plot necessary circles
const_G_circle(real(2/Z0),'m'); % forbidden region circle (g=2)
const_G_circle(real(1/Z0),'c--'); % g=1 circle
% rotated g=1 circle
a=(0:360)*pi/180;
hold on;
plot(0.5*cos(a),0.5+0.5*sin(a),'c--');

global rf_Network; % define a global variable to store a network description

f=1e9; % no frequency is necessary to solve this example
       % but we need frequency to specify in impedance transformations
       % thus we arbitrary set f=1GHz

% define transmission line lengths 
l1=1/8; 
l2=3/8;
l3=3/8;
ls1=0.074;
ls2=0.051;

init_network; % initialize network description
Add_shunt_impedance(ZL);
Add_trans_line(360*l1,f,Z0);
Add_shunt_sc_stub(360*ls1,f,Z0);
Add_trans_line(360*l2,f,Z0);
Add_shunt_sc_stub(360*ls2,f,Z0);
Add_trans_line(360*l3,f,Z0);
Zin=rf_imp_transform(f,sm)


text( 0.03, -0.05,'\bfy_A');
text(-0.78, -0.46,'\bfy_B');
text(-0.43,  0.65,'\bfy_C');
text( 0.45, -0.20,'\bfy_D');
text( 0.11,  0.43,'\bfy_L');

% print -deps 'fig8_28.eps'

