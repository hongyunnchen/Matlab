%
%   This file generates the graph for Example 1.4
%   "RF impedance response of capacitor" 
% 
%   Copyright (c) 1999 by P.Bretchko and R.Ludwig
%   "RF Circuit Design: Theory and Practice"
%

close all; % close all opened graphs
figure;    % open new graph

sigma_Cu=64.516e6; % define material conductivity
mu=4*pi*1e-7;      % define permeability of free space

% define constants for this example
C=47e-12;    % capacitance in Farads
loss=1e-4;   % series loss tangent
l=0.0125;    % length of leads in meters 
a=2.032e-4;  % radius of leads in meters (AWG 26)

% define frequency range
f_min=100e6;  % lower frequency limit
f_max=100e9;  % upper frequency limit
N=300;        % number of points in the graph
f=f_min*((f_max/f_min).^((0:N)/N)); % compute frequency points on log scale
w=2*pi*f;  

L=2*l/(4*pi*a)*sqrt(mu./(pi*sigma_Cu*f)); % lead inductance
Rs=2*l/(2*a)*sqrt(mu*f/(pi*sigma_Cu));    % lead resistance
Re=1./(w*C*loss);                         % leackage resistance
Z=Rs+j*w.*2.*L+1./(j*w*C+1./Re);          % capacitor impedance     
Z_ideal=1./(j*w*C);                       % ideal capacitor impedance

loglog(f,abs(Z),f,abs(Z_ideal));
title('Impedance of a capacitor as function of frequency');
xlabel('Frequency {\itf}, Hz');
ylabel('Impedance |Z|, {\Omega}');

% print -deps 'fig1_12.eps' % if uncommented -> saves a copy of plot in EPS format


