%
%   This program computes the frequency response of 
%   the circuits shown in Figure 8-8 (b) and (c)
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

%*********************
% circuit B
%
ZL=RL+1./(j*w*CL);
L=10.1e-9;
C=2.6e-12;
Z_C=1./(j*w*C);
Z_L=j*w*L;
Zin=Z_C+1./(1./Z_L+1./ZL);

% reflection coefficient
Gamma_B=(Zin-ZS)./(Zin+ZS);

% transfer function
Z1=ZS+Z_C;
Z2=Z_L.*ZL./(Z_L+ZL);
H_B=Z2./(Z1+Z2).*RL./ZL;


%*********************
% circuit C
%
ZL=RL+1./(j*w*CL);
L=9.75e-9;
C=0.6e-12;
Z_C=1./(j*w*C);
Z_L=j*w*L;
Zin=Z_L+1./(1./Z_C+1./ZL);

% reflection coefficient
Gamma_C=(Zin-ZS)./(Zin+ZS);

% transfer function

Z1=ZS+Z_L;
Z2=Z_C.*ZL./(Z_C+ZL);
H_C=Z2./(Z1+Z2).*RL./ZL;

figure;
plot(f/1e9,abs(Gamma_B),f/1e9,abs(Gamma_C));
title('Input reflection coefficient of the circuits shown in Figure 8-8 (b) and (c)');
xlabel('Frequency {\itf}, GHz');
ylabel('Input reflection coefficient, |\Gamma_{in}|');
legend('Network in Figure 8-8 (b)','Network in Figure 8-8 (c)',1);

figure;
plot(f/1e9,20*log10(abs(H_B)),f/1e9,20*log10(abs(H_C)));
axis([0 3 -8 -3]);
title('Transfer function of the circuits shown in Figure 8-8 (b) and (c)');
xlabel('Frequency {\itf}, GHz');
ylabel('Transfer function H, dB');
legend('Network in Figure 8-8 (b)','Network in Figure 8-8 (c)',1);
