%
%   This routine computes attenuation responses of the
%   Chebyshev lowpass filter. The computations are 
%   performed for filters of order 1 through 10
% 
%   Copyright (c) 1999 by P.Bretchko and R.Ludwig
%   "RF Circuit Design: Theory and Practice"
%

close all; % close all opened graphs
clear all; % clear all variables
figure;    % open new graph

w=1:0.01:11; % normalized frequency
N=10;        % define the maximum filter order
ripple=0.5;  % ripple size in the pass band

a=sqrt(10^(ripple/10)-1);

colormap(lines);
color_map=colormap;
colormap('default');

for n=1:N
   LF=1+a^2*(cosh(n*acosh(w))).^2;
   semilogx(w-1,10*log10(LF),'color',color_map(n,:));
   hold on;
end;
title('Response of Chebyshev lowpass filter with 0.5dB ripple');
xlabel('Normalized frequency {\Omega}-1');
ylabel('Attenuation, dB');
axis([0.01 10 0 80]);
text(3,8,'N=1');
text(0.2,60,'N=10');
%print -deps 'fig5_21.eps'     % if uncommented -> saves a copy of plot in EPS format

