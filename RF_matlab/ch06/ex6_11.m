%
%   In this program the drain current is computed for
%   a GaAs HEMT as a function of biasing conditions
%   applied to gate and drain
% 
%   Copyright (c) 1999 by P.Bretchko and R.Ludwig
%   "RF Circuit Design: Theory and Practice"
%

close all; % close all opened graphs
clear all; % clear all variables
figure;    % open new graph

% define problem parameters
Nd=1e18*1e6;
Vb=0.81;
eps_r=12.5;
d=50e-9;
dWc=3.5e-20;
W=10e-6;
L=0.5e-6;
mu_n=8500*1e-4;

% define physical constants
q=1.60218e-19; % electron charge
eps0=8.85e-12; % permittivity of free space

eps=eps_r*eps0;

% pinch-off voltage
Vp=q*Nd*d^2/(2*eps)

% threshold voltage
Vth=Vb-dWc/q-Vp

% drain-source applied voltage range
Vds=0:0.01:5;

% gate-source voltages
Vgs_r=-1:0.25:0;

colormap(lines);
color_map=colormap;
colormap('default');

% for different gate-source voltages find saturation current

for n=1:length(Vgs_r)
   Vgs=Vgs_r(n);
   Id=mu_n*W*eps/(L*d)*((Vds*(Vgs-Vth)-Vds.*Vds/2).*(1-(Vds>(Vgs-Vth)))+1/2*(Vgs-Vth)^2*(1-(Vds<=(Vgs-Vth))));
   plot(Vds,Id/1e-3,'color',color_map(n,:));
   hold on;
end;
   
axis auto;
legend('V_{GS}= -1V','V_{GS}= -0.75V','V_{GS}= -0.5V','V_{GS}= -0.25V','V_{GS}= 0V');
title('Drain current vs. V_{DS} plotted for different V_{GS}');
xlabel('Drain-source voltage V_{DS}, V');
ylabel('Drain current I_{D}, mA');

%print -deps 'fig6_47.eps'
