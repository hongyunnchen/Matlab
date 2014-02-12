%
%   This routine plots the first four Chebyshev polynomials
%   in the normalized frequency range from -1 to 1
% 
%   Copyright (c) 1999 by P.Bretchko and R.Ludwig
%   "RF Circuit Design: Theory and Practice"
%

close all; % close all opened graphs
clear all; % clear all variables
figure;    % open new graph

w=-1:0.01:1;

% define chebyshev polynomials
T1=w;
T2=-1+2*w.^2;
T3=-3*w+4*w.^3;
T4=1-8*w.^2+8*w.^4;

plot(w,T1,w,T2,w,T3,w,T4);
axis square;

text(0.5,0.7,'{T_1} \rightarrow');
text(0.6,0.3,'{T_2} \rightarrow');
text(-0.7,0.6,'\leftarrow {T_3}');
text(0.2,0.8,'\leftarrow {T_4}');
title('Chebyshev polynomials');
xlabel('Normalized frequency \Omega');
%print -deps 'fig5_19.eps'
