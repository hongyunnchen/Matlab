%
%   This program generates a Smith Chart plot 
%   and computes the frequency response of the 
%   matching neworks described in Example 8.4
% 
%   Copyright (c) 1999 by P.Bretchko and R.Ludwig
%   "RF Circuit Design: Theory and Practice"
%

close all; % close all opened graphs
clear all; % clear all variables

global Z0;
set_Z0(50); % set characteristic line impedance to 50 Ohm

% define source and load impedances
RS=50;
RL=25;
LL=3.18e-9;

f0=1e9;
w0=2*pi*f0;
ZL=RL+j*w0*LL;

% create Smith Chart
sm=smith_chart;
% plot Qn=1 contour
Qn_contours(1,sm);
text(0.1,0.5,'\bfQ_n=1');
text(0.1,-0.5,'\bfQ_n=1');

global rf_Network; % define a global variable to store network description

% circuit A (see Figure 8-12 (b))
L1=0.8e-9;
C1=3.18e-12;
init_network; % initialize network description
Add_shunt_impedance(ZL);
Add_series_inductor(L1);
Add_shunt_capacitor(C1);
rf_imp_transform(f0,sm);

text(-0.22, 0.47,'\bfA');
text(-0.37, 0.32,'\bfz_L');

% circuit B (see Figure 8-12 (c))
L2=7.96e-9;
C2=3.54e-12;
init_network; % initialize network description
Add_shunt_impedance(ZL);
Add_series_capacitor(C2);
Add_shunt_inductor(L2);
rf_imp_transform(f0,sm);
text(-0.22, -0.47,'\bfB');

% print -deps 'fig8_12a.eps'


% find frequency response of these two networks
f=1e6:1e6:4e9;
w=2*pi*f;

ZL=RL+j*w*LL;

ZL1=j*w*L1;
ZL2=j*w*L2;
ZC1=1./(j*w*C1);
ZC2=1./(j*w*C2);

Z1a=ZL+ZL1;
Z1b=ZC1.*Z1a./(ZC1+Z1a);
Zin1=Z0+Z1b;
H1=Z1b./Zin1.*RL./Z1a;

Z2a=ZL+ZC2;
Z2b=ZL2.*Z2a./(ZL2+Z2a);
Zin2=Z0+Z2b;
H2=Z2b./Zin2.*RL./Z2a;

figure;
plot(f/1e9,20*log10(abs(H1)),'b',f/1e9,20*log10(abs(H2)),'r');
axis([0 4 -15 -8]);
title('Frequency response of matching networks');
xlabel('Frequency {\itf}, GHz');
ylabel('Transfer function {\itH = V_{out} / V_{s}}, dB');
legend('Network in Figure 8-12 (b)','Network in Figure 8-12 (c)',1);


% print -deps 'fig8_13.eps'

