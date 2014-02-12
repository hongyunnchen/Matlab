%
%   This file computes the input impedance of the
%   short-circuit transmission line as described in Example 2.6
% 
%   Copyright (c) 1999 by P.Bretchko and R.Ludwig
%   "RF Circuit Design: Theory and Practice"
%

close all; % close all opened graphs
figure;    % open a new graph

% define distributed transmission line parameters
L=209.410e-9;  % line inductance in H/m
C=119.510e-12; % line capacitance in F/m

vp=1/sqrt(L*C); % phase velocity
Z0=sqrt(L/C);   % characteristic line impedance

d=0.1;  % line length
N=5000; % number of frequency sampling points

f=1e9+3e9*(0:N)/N;
Z=tan(2*pi*f*d/vp);

plot(f,abs(Z0*Z));
title('Skin depth as a function of frequency');
xlabel('Frequency {\itf}, Hz');
ylabel('Skin depth {\delta}, m');
axis([1e9 4e9 0 500]);
% print -deps 'fig2_28.eps' % if uncommented -> saves a copy of plot in EPS format
