%
%   This program computes the frequency response of 
%   the circuits shown in Figure 8-8 (c) and 
%   compares it with the response of the equivalent 
%   filter shown in Figure 8-10 (a)
% 
%   Copyright (c) 1999 by P.Bretchko and R.Ludwig
%   "RF Circuit Design: Theory and Practice"
%

close all; % close all opened graphs
clear all; % clear all variables

% specify load and source impedances
RL=80;
CL=2.65e-12;
ZS=50;

f=(0.01:0.01:3)*1e9;
w=2*pi*f;

%****************************
% circuit in Figure 8-8(c)
%
ZL=RL+1./(j*w*CL);
L=9.75e-9;
C=0.6e-12;
Z_C=1./(j*w*C);
Z_L=j*w*L;
Z1=ZS+Z_L;
Z2=Z_C.*ZL./(Z_C+ZL);
H_C=Z2./(Z1+Z2).*RL./ZL;

%****************************
% equivalent filter
%

R_ST=125.1;
C_T=1.55e-12;
L_LN=16.2e-9;
R_LP=125.1;
Z_1=1./(j*w*C_T+1./(j*w*L_LN)+1/R_LP);
KK=1-j*2*pi*1e9*L/ZS; % this is coefficient for Thevenin equivalent voltage source
H_filter=KK.*Z_1./(Z_1+R_ST);

figure;
plot(f/1e9,20*log10(abs(H_C)),f/1e9,20*log10(abs(H_filter)));
axis([0 3 -8 -2]);
title('Frequency response of the matching network and equivalent filter');
xlabel('Frequency {\itf}, GHz');
ylabel('Transfer function H, dB');
legend('Network in Figure 8-8 (c)','Equivalent filter',1);
