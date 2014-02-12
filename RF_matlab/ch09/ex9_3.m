%
%   In this example we plot input and output stability circles
%   for the BJT whose S-parameters are measured at several 
%   frequencies. In this simulation we use the type BFG505W biased 
%   at Vce=6V and Ic=4mA
% 
%   Copyright (c) 1999 by P.Bretchko and R.Ludwig
%   "RF Circuit Design: Theory and Practice"
%

close all;   % close all opened graphs
clear all;   % clear all variables

smith_chart; % create a Smith Chart

% f=500MHz
s11=0.384-j*0.584;
s12=0.029+j*0.031;
s21=-7.631+j*7.258;
s22=0.661-j*0.433;

s_param=[s11,s12;s21,s22];     % convert the S-parameters into matrix notation

input_stability(s_param, 'r'); % plot input stability circle in red color
output_stability(s_param, 'b');% plot output stability circle in blue color

% f=750MHz
s11=0.114-j*0.551;
s12=0.044+j*0.029;
s21=-4.608+j*7.312;
s22=0.490-j*0.449;

s_param=[s11,s12;s21,s22];

input_stability(s_param, 'r');
output_stability(s_param, 'b');

% f=1000MHz
s11=-0.058-j*0.452;
s12=0.054+j*0.022;
s21=-2.642+j*6.641;
s22=0.379-j*0.424;

s_param=[s11,s12;s21,s22];

input_stability(s_param, 'r');
output_stability(s_param, 'b');

% f=1250MHz
s11=-0.160-j*0.343;
s12=0.059+j*0.015;
s21=-1.407+j*5.846;
s22=0.307-j*0.392;

s_param=[s11,s12;s21,s22];

input_stability(s_param, 'r');
output_stability(s_param, 'b');

%print -deps 'fig9_8.eps'
