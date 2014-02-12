%
%   This file generates the graph for Example 3.1
%   "Reflection coefficient representations" 
% 
%   Copyright (c) 1999 by P.Bretchko and R.Ludwig
%   "RF Circuit Design: Theory and Practice"
%

close all; % close all opened graphs
figure;    % open new graph

Z0=50;     % define 50 Ohm characteristic impedance

% define impedances for this example
Z=[0 1e25 50 16.67-16.67*j 50+150*j];
%      |
%      +----- we use this impedance to represent Z->infinity
%

% compute reflection coefficient for each impedance
Gamma=(Z-Z0)./(Z+Z0);

% plot reflection coefficients in polar form
polar(angle(Gamma),abs(Gamma),'ro');

% annotate the graph
for n=1:length(Z)
   txt=strcat('{\bf\Gamma_',sprintf('%c','a'+n-1),'}');
   text(real(Gamma(n))+0.02, imag(Gamma(n))+0.06, txt,'color',[1 0 0]);
end;

% print -deps 'fig3_1.eps' % if uncommented -> saves a copy of plot in EPS format
