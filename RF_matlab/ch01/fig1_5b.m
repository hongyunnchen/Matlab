%
%   This file generates the graph of the current density in
%   in a copper conductor of radius a=1mm as a function of
%   operating frequency. 
% 
%   Copyright (c) 1999 by P.Bretchko and R.Ludwig
%   "RF Circuit Design: Theory and Practice"
%

close all; % close all opened graphs
figure;    % open new graph

a=0.001;   % radius of the wire
N=100;     % the number of steps along the radius
r=a*(0:N)/N;       % define an array of values for sweeping the value of r
sigma_Cu=64.516e6; % conductivity of copper material
mu=4*pi*1e-7;      % permeability of free space

order=[3:9];  % define order of frequencies at which distribution will be plotted
              % 3 - kHz, 6 - MHz, 9 - GHz, etc.
              
colormap(lines);
color_map=colormap;
colormap('default');

for n=1:length(order)
                  % for each frequency 
   f=10^order(n); % compute frequency
   pp=sqrt(-j*2*pi*f*mu*sigma_Cu);            % define parameter p
   Jz=pp*a/2*besselj(0,pp*r)/besselj(1,pp*a); % normalized current density
   
   plot(r/1e-3,abs(Jz),'color',color_map(n,:)); % plot graph Jz vs. r for given frequency
   hold on;                                     % this prevents the graph from being overdrawn
end;

axis([0 1 0 2]);                                % set axes 
title('Normalized current density in copper conductor');
xlabel('Radial distance from the center {\itr}, mm');
ylabel('Normalized current density {J_z/J_0_z}');

%print -deps 'fig1_5b.eps'     % if uncommented -> saves a copy of plot in EPS format

