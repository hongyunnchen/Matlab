%
%   This routine computes Butterworth lowpass filter
%   response. Computations are performed for filters 
%   of order 1 through 10
% 
%   Copyright (c) 1999 by P.Bretchko and R.Ludwig
%   "RF Circuit Design: Theory and Practice"
%

close all; % close all opened graphs
clear all; % clear all variables
figure;    % open new graph

w=1:0.01:11; % normalized frequency
N=10;        % define the maximum filter order

colormap(lines);
color_map=colormap;
colormap('default');

for n=1:N
   LF=1+w.^(2*n);
   semilogx(w-1,10*log10(LF),'color',color_map(n,:));
   hold on;
end;
title('Butterworth lowpass filter response');
xlabel('Normalized frequency {\Omega}-1');
ylabel('Attenuation, dB');
axis([0.1 10 0 80]);
%print -deps 'fig5_18.eps'   % if uncommented -> saves a copy of plot in EPS format

