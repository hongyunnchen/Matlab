%
%   This file generates the impedance transformations 
%   produced by the network shown in Figure 3-17
%   The result is shown in Figure 3-18
% 
%   Copyright (c) 1999 by P.Bretchko and R.Ludwig
%   "RF Circuit Design: Theory and Practice"
%

close all; % close all opened graphs
clear all; % clear all global variables

figure;  % open new graph

global rf_Network; % define a global variable to store the network description

init_network; % initialize the network description

% define a network (the same network as in Figure 3-17)
Add_shunt_impedance(31.25);
Add_shunt_capacitor(1.91e-12);
Add_series_inductor(4.38e-9);
Add_shunt_capacitor(2.39e-12);
Add_series_inductor(3.98e-9);

% set characteristic impedance necessary to plot the Smith Chart
set_Z0(50);                 

% plot the impedance transformations at 2GHz
fig=rf_imp_transform(2e9);

% print -deps 'fig3_18.eps' % if uncommented -> saves a copy of plot in EPS format

% now we can compute the frequency response of this network

% first, we define the frequency range
f=(0.5 : 0.01 : 4)*1e9;
%    |     |    |   |
%    |     |    |   +----- multiplier for GHz
%    |     |    |   
%    |     |    +--------- upper limit (4GHz)
%    |     |    
%    |     +-------------- step 0.01GHz = 10MHz
%    |       
%    +-------------------- lower limit 0.5GHz = 500MHz


% create an array to store the values of the network impedance
Z=zeros([1 length(f)]);

% for each frequency point compute input impedance of the network
for n=1:length(f)
   Z(n)=rf_get_impedance(f(n));
end;

% create a Smith Chart
smith_chart;
hold on; % make sure that we don't erase it from the figure

% compute input reflection coefficient assuming 50 Ohm system impedance
Gamma=(Z-50)./(Z+50);

% plot it on the Smith Chart
plot(real(Gamma), imag(Gamma),'linewidth',2);

% now we annotate the graph
f=[0.5 1 2 3 4]*1e9; % frequency points that we would like to identify in the graph

for n=1:length(f)
   Z=rf_get_impedance(f(n));
   Gamma=(Z-50)./(Z+50);
   plot(real(Gamma), imag(Gamma), 'ro');
   txt=strcat('{\bf',sprintf('%g',f(n)/1e9),'GHz}');
   text(real(Gamma)-0.05, imag(Gamma)-0.08,txt,'color',[0.1 0 0.8]);
end;   

% print -deps 'fig3_19.eps' % if uncomment -> saves a copy of plot in EPS format
