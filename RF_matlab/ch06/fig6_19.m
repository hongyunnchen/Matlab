%
%   This program plots the capacitance of the varactor diode
% 
%   Copyright (c) 1999 by P.Bretchko and R.Ludwig
%   "RF Circuit Design: Theory and Practice"
%

close all; % close all opened graphs
clear all; % clear all variables
figure;    % open a new graph

% define the range for the applied voltage
VQ=-2:0.01:0;

% diffusion voltage
Vdif=0.5;

% capacitance at zero applied voltage
Cv0=0.2; % given in pF

C=Cv0*(1-VQ/Vdif).^(-1/2);
plot(VQ,C)
title('Varactor diode capacitance vs. applied voltage');
xlabel('Biasing voltage V_Q, V');
ylabel('Capacitance C_v, pF');
%print -deps 'fig6_19.eps'

