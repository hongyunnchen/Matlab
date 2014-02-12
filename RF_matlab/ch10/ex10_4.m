%
%   In this example we plot the input stability circle
%   for the BFQ65 BJT in common-base configuration.
%   This plot is subsequently used in the oscillator 
%   design as explained in Example 10-4
% 
%   Copyright (c) 1999 by P.Bretchko and R.Ludwig
%   "RF Circuit Design: Theory and Practice"
%

close all; % close all opened graphs
clear all; % clear all variables

% characteristic impedance 
Z0=50;

% oscillation frequency
f=1.5e9;
w=2*pi*f;

% BFQ65 transistor S-parameters at osc. freq. (common base, Vce=3V, Vbe=0.9V)
s_tr=[-0.859+j*1.196,-0.209+j*0.252;0.994-j*1.940,0.880-j*0.865];

s11=s_tr(1,1);
s12=s_tr(1,2);
s21=s_tr(2,1);
s22=s_tr(2,2);

% plot stability circles
smith_chart;
input_stability(s_tr,'r')

%print -deps 'fig10_15.eps'
