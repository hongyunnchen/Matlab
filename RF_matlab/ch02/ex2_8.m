%
%   This program computes the input impedance of the
%   quarter-wave transformer as described in Example 2.8
% 
%   Copyright (c) 1999 by P.Bretchko and R.Ludwig
%   "RF Circuit Design: Theory and Practice"
%

close all; % close all opened graphs
figure;    % open new graph

% define necessary parameters

ZL=25;    % load impedance
Z0=50;    % desired input impedance
eps=4;    % relative dielectric constant
dp=0.001; % dielectric thickness in meters
f0=500e6; % frequency at which a perfect match has to achieved

% physical constants
mu0=4*pi*1e-7; % permeability of free space
eps0=8.85e-12; % permittivity of free space

% compute required characteristic line impedance
Zline=sqrt(Z0*ZL);

% find the width of the line
w=dp/Zline*sqrt(mu0/eps0/eps);

% compute distributed transmission line parameters
L=mu0*dp/w;       % line inductance in H/m
C=eps0*eps*w/dp;  % line capacitance in F/m

vp=1/sqrt(L*C);   % phase velocity
Z0=sqrt(L/C);     % characteristic line impedance

d=1/(4*f0*sqrt(L*C)); % length of the line

N=100;            % number of frequency sampling points
f=2e9*(0:N)/N;    % frequency range

betta=2*pi*f/vp;  % propagation constant

Z=Zline*((ZL+j*Zline*tan(betta*d))./(Zline+j*ZL*tan(betta*d)));

plot(f/1e9,real(Z));

title('Input impedance of the quarter-wave transformer');
xlabel('Frequency {\itf}, GHz');
ylabel('Input impedance Z_{in}, {\Omega}');
axis([0 2 0 50]);

% print -deps 'fig2_33.eps' % if uncommented -> saves a copy of plot in EPS format
