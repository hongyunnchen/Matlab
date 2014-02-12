%
%   This file generates the graph for Example 1.5
%   "RF impedance response of wire-wound inductor" 
% 
%   Copyright (c) 1999 by P.Bretchko and R.Ludwig
%   "RF Circuit Design: Theory and Practice"
%

clear all; % clear all variables
close all; % close all opened graphs
figure;    % open new graph

sigma_Cu=64.516e6; % define material conductivity
mu=4*pi*1e-7;      % define permeability of free space
epsilon=8.85e-12;  % define permittivity of free space

% define constants for this example
a=63.5e-6;  % radius of wire
r=1.27e-3;  % radius of coil
l=1.27e-3;  % length of coil
NN=3.5;     % number of turns

% compute parameters of the equivalent circuit
L=pi*r^2*mu*NN^2/l;  % inductance of the computed coil 
                     % using the formula for a solenoid
C=4*pi*epsilon*r*a*NN^2/l;     % capacitance between turns
R=2*pi*r*NN/(sigma_Cu*pi*a^2); % resistance of the wire

% define frequency range
f_min=100e6;  % lower frequency limit
f_max=100e9;  % upper frequency limit
N=300;        % number of points in the graph
f=f_min*((f_max/f_min).^((0:N)/N)); % compute frequency points on log scale
w=2*pi*f;  

Z=1./(j*w*C+1./(R+j*w*L)); % impedance of the coil
Z_ideal=j*w*L;             % ideal inductor impedance     

loglog(f,abs(Z),f,abs(Z_ideal));
title('Impedance of a capacitor as function of frequency');
xlabel('Frequency {\itf}, Hz');
ylabel('Impedance |Z|, {\Omega}');
legend('wire-wound inductor', 'ideal inductor');

% print -deps 'fig1_17.eps' % if uncommented -> saves a copy of plot in EPS format
