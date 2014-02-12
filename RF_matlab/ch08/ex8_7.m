%
%   This program generates an impedance transformation 
%   plot in the Smith Chart and finds the input impedance of the 
%   matching network as a function of the shunt capacitance position
% 
%   Copyright (c) 1999 by P.Bretchko and R.Ludwig
%   "RF Circuit Design: Theory and Practice"
%

close all; % close all opened graphs
clear all; % clear all variables

global Z0;
set_Z0(50); % set characteristic line impedance to 50 Ohm

% define load impedances
ZL=30+j*10;

f=1.5e9;
w=2*pi*f;

% create Smith Chart
sm=smith_chart;

global rf_Network; % define a global variable to store the network description

% define a matching network
l1=0.055; % length of the first transmission line in terms of wavelength
C1=4.37e-12; % shunt capacitance
l2=0.259; % length of the second transmission line in terms of wavelength

init_network; % initialize network description
Add_shunt_impedance(ZL);
Add_trans_line(360*l1,f,Z0);
Add_shunt_capacitor(C1);
Add_trans_line(360*l2,f,Z0);
Zin=rf_imp_transform(f,sm)

text(-0.35, 0.17,'\bfz_L');
text(-0.11, 0.36,'\bfA');
text(-0.39, -0.56,'\bfB');
text(0.48, 0.45,'\bfz_{in}');

% print -deps 'fig8_20.eps'


% attempt to find the input impedance as a function of the capacitor position
yc=j*w*C1*Z0; % normalized capacitor admittance
theta_total=2*pi*(l1+l2); % combined electrical lengths of lines 1 and 2 

theta=(0:0.01:1)*theta_total; % theta defines changing position of the cap.

zl=ZL/Z0;              % normalized load impedance
G0=(zl-1)/(zl+1);      % reflection coefficient at the load
G1=G0*exp(-j*2*theta); % reflection coefficient at the location of capacitor attachement
y1=(1-G1)./(1+G1);     % normalized admittance at that point
ycl=y1+yc;             % added capacitor
Gc=(1-ycl)./(1+ycl);
Gin=Gc.*exp(-j*2*(theta_total-theta));
zin=(Gin+1)./(1-Gin);  % normalized input impedance

figure; % create new figure
plot(theta/2/pi,real(zin),'linewidth',2);
title('Normalized input impedance as a function of capacitor position');
xlabel('Distance {\itl}, \lambda');
ylabel('Normalized input resistance, r_{in}');
%print -deps 'fig8_22a.eps'

figure; % create new figure
plot(theta/2/pi,imag(zin),'linewidth',2);
title('Normalized input impedance as a function of capacitor position');
xlabel('Distance {\itl}, \lambda');
ylabel('Normalized inpur reactance, x_{in}');
%print -deps 'fig8_22b.eps'
