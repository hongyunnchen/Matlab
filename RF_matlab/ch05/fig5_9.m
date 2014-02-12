%
%   This file computes the attenuation profile of the first 
%   order RL filter for various load resistances
% 
%   Copyright (c) 1999 by P.Bretchko and R.Ludwig
%   "RF Circuit Design: Theory and Practice"
%

close all; % close all opened graphs
clear all; % clear all variables
f1=figure; % open new graph for the attenuation
f2=figure; % open new graph for the phase plot

% define problem parameters
L=100e-9; % filter inductance
R=10;     % filter resistance
Rg=50;    % source impedance
RL=[5 20 50 100 250 1e3]; % load imperances for which the 
                          % transfer function is computed
% define frequency range
f_min=1e6;  % lower frequency limit
f_max=10e9; % upper frequency limit
N=100;      % number of points in the graph
f=f_min*((f_max/f_min).^((0:N)/N)); % compute frequency points on log scale
w=2*pi*f;  

colormap(lines);
color_map=colormap;
colormap('default');

for n=1:length(RL)
   H=1./(1+(R+Rg)*(1./(j*w*L)+1/RL(n)));
   figure(f1);
   semilogx(f,-20*log10(abs(H)),'color',color_map(n,:));
   hold on;
   phase=atan(imag(H)./real(H));
   figure(f2);
   semilogx(f,phase/pi*180,'color',color_map(n,:));
   hold on;
end;

figure(f1);
title('Attenuation profile of the RL filter for various load resistances');
xlabel('Frequency, Hz');
ylabel('Attenuation, dB');

%print -deps 'fig5_9a.eps'     % if uncommented -> saves a copy of plot in EPS format

figure(f2);
title('Phase response of filter for various load resistances');
xlabel('Frequency, Hz');
ylabel('Phase, degree');

%print -deps 'fig5_9b.eps'     % if uncommented -> saves a copy of plot in EPS format

