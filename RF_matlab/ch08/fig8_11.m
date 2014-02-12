%
%   This program generates a Smith Chart plot with 
%   constant nodal quality factor contours
% 
%   Copyright (c) 1999 by P.Bretchko and R.Ludwig
%   "RF Circuit Design: Theory and Practice"
%

close all; % close all opened graphs
clear all; % clear all variables

fn=smith_chart;  % create a Smith Chart
Qn=[0.3 1 3 10]; % define Qn for which we would like to obtain the contours

Qn_contours(Qn,fn); % plot constant Qn contours
text(-0.1,0.95,'\bfQ_n=10');
text(-0.08,0.77,'\bfQ_n=3');
text(-0.08,0.47,'\bfQ_n=1');
text(-0.12,0.2,'\bfQ_n=0.3');
text(-0.1,-0.96,'\bfQ_n=10');
text(-0.08,-0.77,'\bfQ_n=3');
text(-0.08,-0.47,'\bfQ_n=1');
text(-0.12,-0.2,'\bfQ_n=0.3');

% print -deps 'fig8_11.eps'
