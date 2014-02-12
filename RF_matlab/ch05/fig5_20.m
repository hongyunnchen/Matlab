%
%   This routine generates graphs of the loss factor and
%   insertion loss of the lowpass Chebyshev filters
%   of order 1 through 4.
% 
%   Copyright (c) 1999 by P.Bretchko and R.Ludwig
%   "RF Circuit Design: Theory and Practice"
%

close all; % close all opened graphs
clear all; % clear all variables

w=0:0.01:2;

% define Chebyshev polynomials
T1=w;
T2=-1+2*w.^2;
T3=-3*w+4*w.^3;
T4=1-8*w.^2+8*w.^4;

% compute corresponding loss factors
LF1=1+T1.^2;
LF2=1+T2.^2;
LF3=1+T3.^2;
LF4=1+T4.^2;

figure;    % open new graph
plot(w,LF1,w,LF2,w,LF3,w,LF4);
axis([0 2 1 6]);
title('Loss factor of the lowpass Chebyshev filter');
xlabel('Normalized frequency \Omega');
ylabel('Loss factor');
legend('N=1','N=2','N=3','N=4',2);
%print -deps 'fig5_20a.eps'

figure;    % open new graph
plot(w,10*log10(LF1),w,10*log10(LF2),w,10*log10(LF3),w,10*log10(LF4));
hold on;
plot([0 1],[3 3],'b:',[1 1],[0 3],'b:');
axis([0 2 0 30]);
title('Insertion loss of lowpass Chebyshev filter');
xlabel('Normalized frequency \Omega');
ylabel('Insertion loss, dB');
legend('N=1','N=2','N=3','N=4',2);
text(0.2,4,'{\bf3dB ripples}');
%print -deps 'fig5_20b.eps'
