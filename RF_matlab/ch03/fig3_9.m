%
%   This file generates the graph shown in Figure 3-9
% 
%   Copyright (c) 1999 by P.Bretchko and R.Ludwig
%   "RF Circuit Design: Theory and Practice"
%

close all; % close all opened graphs
figure;  % open new graph

smith_chart;   % plot the Smith Chart

% define global variables
global Z0;     
global ZL;     

Set_Z0(50);    % set characteristic impedance to 50 Ohm

s_Load(30+j*60);  % set load impedance to 30+j60 Ohm

vp=0.5*3e8;       % compute phase velocity 
f=2e9;            % operating frequency

d=0.0:0.001:0.03;  % set the line length to a range from
                   % 0 to 3cm in 1mm increments

betta=2*pi*f/vp;     % compute the propagation constant

% compute the load refection coefficient
Gamma=(ZL-Z0)/(ZL+Z0);

% find the magnitude of the reflection coefficient
rd=abs(Gamma);

alpha=angle(Gamma)-2*betta*d; % phase of the input reflection coefficient

hold on;
plot(rd*cos(alpha), rd*sin(alpha),'linewidth',2); % plot the path on the Smith Chart
plot(rd*cos(alpha(length(alpha))), rd*sin(alpha(length(alpha))),'ro');

% print -deps 'fig3_9.eps' % if uncomment -> saves a copy of plot in EPS format

