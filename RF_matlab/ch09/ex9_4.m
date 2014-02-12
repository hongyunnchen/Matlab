%
%   This routine plots the input and output stability circles
%   for a hypothetical transistor and whose S-parameters 
%   are defined in Exmaple 9-4
% 
%   Copyright (c) 1999 by P.Bretchko and R.Ludwig
%   "RF Circuit Design: Theory and Practice"
%

close all; % close all opened graphs
clear all; % clear all variables

smith_chart; % create a Smith Chart

% S-parameters for the hypothetical transistor

s11=0.7*exp(j*(-70)/180*pi);
s12=0.2*exp(j*(-10)/180*pi);
s21=5.5*exp(j*(+85)/180*pi);
s22=0.7*exp(j*(-45)/180*pi);

s_param=[s11,s12;s21,s22];

[K,delta] = K_factor(s_param) % check stability

input_stability(s_param, 'r');
output_stability(s_param, 'b');

% print -deps 'fig9_9.eps'

