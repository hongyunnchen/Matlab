%
%   In this example we compute the resonance frequencies of the
%   quartz crystal resonator
% 
%   Copyright (c) 1999 by P.Bretchko and R.Ludwig
%   "RF Circuit Design: Theory and Practice"
%

close all; % close all opened graphs
clear all; % clear all variables
figure;

% define crystal parameters
Lq=0.1;
Rq=25;
Cq=0.3e-12;
C0=1e-12;

% find series resonance frequency
ws0=1/sqrt(Lq*Cq);
ws=ws0*(1+Rq^2/2*C0/Lq);
fs=ws/2/pi 

% find parallel resonance frequency
wp0=sqrt((Cq+C0)/(Lq*Cq*C0));
wp=wp0*(1-Rq^2/2*C0/Lq);
fp=wp/2/pi

% define frequency range for this plot
f=(0.9:0.00001:1.1)*1e6;
w=2*pi*f;

% find abmittance of the resonator
Y=j*w*C0+1./(Rq+j*(w*Lq-1./(w*Cq)));

semilogy(f/1e6,abs(imag(Y)));
axis([0.9 1.1 1e-10 1e-1]);
title('Admittance of the quartz crystal resonator');
xlabel('Frequency {\itf}, MHz');
ylabel('Susceptance |B|, \Omega');
text(0.92,1e-2,'Series resonance');
text(1.05,1e-9,'Parallel resonance');
% print -deps 'fig10_11.eps'
