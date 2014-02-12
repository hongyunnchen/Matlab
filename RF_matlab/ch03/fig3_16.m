%
%   This file generates the plot shonw in Figure 3-16
% 
%   Copyright (c) 1999 by P.Bretchko and R.Ludwig
%   "RF Circuit Design: Theory and Practice"
%

global Z0;
close all; % close all opened graphs
figure;  % open new graph
smith_chart;

Z0=50; % define characteristic impedance

% define values of normalized resistance 
r=[0.3 0.5 0.7 1];

C=1e-12; % set capacitance value to 1pF

% define frequency range
fmin=0.5e9; % minimum frequency (500MHz) 
fmax=4e9;   % maximum frequency (4GHz)

% compute normalized reactance of the capacitor
xmin=1/(j*2*pi*fmin*C)/Z0 % at minimum frequency
xmax=1/(j*2*pi*fmax*C)/Z0 % and at maximum frequency

% for each value of normalized resistance
for n=1:length(r)
   % plot corresponding arc on the constant resistance circle
   s_ArcR(r(n)*Z0,imag(xmin*Z0),imag(xmax*Z0));
end;

text(-0.3,-0.5,'{\bff=4GHz}');
text(0.85,-0.25,'{\bff=500MHz}');

% print -deps 'fig3_16.eps' % if uncomment -> saves a copy of plot in EPS format
