%
%   This program generates a Smith Chart plot for Example 8.2
% 
%   Copyright (c) 1999 by P.Bretchko and R.Ludwig
%   "RF Circuit Design: Theory and Practice"
%

close all;            % close all opened graphs
clear all;            % clear all variables
fig_num=Smith_Chart;  % open new graph

global rf_Network; % define a global variable to store network description

init_network;      % initialize network description

% set characteristic impedance
set_Z0(75);                           

% transmitter impedance
ZT=150+j*75;
YT=1/ZT;

const_R_circle(75,'c--');
const_G_circle(real(YT),'c--');

% define a network
Add_shunt_impedance(ZT);
Add_shunt_capacitor(0.73e-12);
Add_series_inductor(6.1e-9);

fig=rf_imp_transform(2e9,fig_num);

%print -deps 'fig8_4.eps'
