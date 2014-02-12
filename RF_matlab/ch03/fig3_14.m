%
%   This file generates the plot shown in Figure 3-14
% 
%   Copyright (c) 1999 by P.Bretchko and R.Ludwig
%   "RF Circuit Design: Theory and Practice"
%

close all; % close all opened graphs
figure;    % open new graph
smith_chart;

Z0=50; % define 50 Ohm characteristic impedance

% define values of normalized conductance 
g=[0.3 0.5 0.7 1];

C=1e-12; % set capacitance value to 1pF

% define frequency range
fmin=0.5e9; % minimum frequency (500MHz) 
fmax=4e9;   % maximum frequency (4GHz)

% compute normalized susceptance of the capacitor  
bmin=Z0*(j*2*pi*fmin*C) % at minimum frequency
bmax=Z0*(j*2*pi*fmax*C) % and at maximum frequency

% for each value of normalized conductance
for n=1:length(g)
   % plot corresponding arc on the constant conductance circle
   s_ArcG(g(n)/Z0,imag(bmin/Z0),imag(bmax/Z0));
end;

text(-0.5,-0.60,'{\bff=4GHz}');
text(0.15,-0.05,'{\bff=500MHz}');

% print -deps 'fig3_14.eps' % if uncommented -> saves a copy of plot in EPS format
