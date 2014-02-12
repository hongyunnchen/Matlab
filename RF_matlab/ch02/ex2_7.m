%
%   This file computes an input impedance of an
%   open-circuit line as described in Example 2.7
% 
%   Copyright (c) 1999 by P.Bretchko and R.Ludwig
%   "RF Circuit Design: Theory and Practice"
%

close all; % close all opened graphs
figure;    % open new graph

% define distributed transmission line parameters
L=209.410e-9;  % line inductance in H/m
C=119.510e-12; % line capacitance in F/m

vp=1/sqrt(L*C); % phase velocity
Z0=sqrt(L/C);   % characteristic line impedance

d=0.1;  % line length
N=5000; % number of sampling points

f=1e9+3e9*(0:N)/N;  % frequency range
Z=cot(2*pi*f*d/vp); % impedance of open-circuit transmission line

plot(f/1e9,abs(Z0*Z));
title('Input impedance of an open-circuit line');
xlabel('Frequency {\itf}, GHz');
ylabel('Input impedance |Z|, {\Omega}');
axis([1 4 0 500]);
% print -deps 'fig2_30.eps' % if uncommented -> saves a copy of plot in EPS format
