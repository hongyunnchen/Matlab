%
%   This file generates the graph for Example 3.4
%   "Reflection coefficient representations" 
% 
%   Copyright (c) 1999 by P.Bretchko and R.Ludwig
%   "RF Circuit Design: Theory and Practice"
%

close all; % close all opened graphs
figure;    % open new graph

Z0=50;     % define 50 Ohm characteristic impedance

% define impedances for this example
Z=[50 48.5 75+j*25 10-j*5];

% compute corresponding reflection coefficients
Gamma=(Z-Z0)./(Z+Z0)

% find the SWRs
SWR=(1+abs(Gamma))./(1-abs(Gamma));

smith_chart;

hold on;
a=0:0.01:2*pi;
for n=1:length(Z)
   % plot SWR circle
   plot(abs(Gamma(n))*cos(a),abs(Gamma(n))*sin(a),'b','linewidth',2);
   % plot reflection coefficient
   plot(real(Gamma(n)), imag(Gamma(n)),'ro');
end;

for n=1:length(Z)
   if n~=1 % we do not want to plot SWR value for Z=Z0
      txt=strcat('{\bfSWR=',sprintf('%1.2f',SWR(n)),'}');
      text(real(Gamma(n))+0.02, imag(Gamma(n))+0.06, txt,'color',[1 0 0]);
   end;
end;

hold off;
% print -deps 'fig3_6.eps' % if uncommented -> saves a copy of plot in EPS format
