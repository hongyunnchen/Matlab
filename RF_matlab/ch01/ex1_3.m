%
%   This file generates the graph for Example 1.3
%   "RF impedance response of metal film resistor" 
% 
%   Copyright (c) 1999 by P.Bretchko and R.Ludwig
%   "RF Circuit Design: Theory and Practice"
%

close all; % close all opened graphs
figure;    % open new graph

sigma_Cu=64.516e6; % define material conductivity
mu=4*pi*1e-7;      % permeability of free space

% define constants for this example
R=500;       % resistance in Ohms
C=5e-12;     % capacitance in Farads
l=0.025;     % length of leads in meters 
a=2.032e-4;  % radius of the leads in meters (AWG 26)

% define frequency range
f_min=1e6;    % lower frequency limit
f_max=1000e9; % upper frequency limit
N=300;        % number of points in the graph
f=f_min*((f_max/f_min).^((0:N)/N)); % compute frequency points on log scale

L=2*l/(4*pi*a)*sqrt(mu./(pi*sigma_Cu*f)); % determine inductance
Z=1./(j*2*pi*f*C+1/R)+j*2*pi*f.*L;        % determine impedance

loglog(f,abs(Z));
title('Impedance of a 500 {\Omega} thin-film resistor as a function of frequency');
xlabel('Frequency {\itf}, Hz');
ylabel('Impedance |Z|, {\Omega}');

% print -deps 'fig1_10.eps' % if uncomment -> saves a copy of plot in EPS format
