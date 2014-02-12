%
%   This routine computes the Butterworth lowpass filter
%   response. The computations are performed for filters 
%   of order 1 through 5
% 
%   Copyright (c) 1999 by P.Bretchko and R.Ludwig
%   "RF Circuit Design: Theory and Practice"
%

close all; % close all opened graphs
clear all; % clear all variables
figure;    % open new graph

w=0:0.01:2; % normalized frequency
N=5;        % define the maximum filter order

colormap(lines);
color_map=colormap;
colormap('default');
legend_string=' ';

for n=1:N
   LF=1+w.^(2*n);
   plot(w,10*log10(LF),'color',color_map(n,:));
   hold on;
   legend_string=strcat(legend_string,sprintf('N=%g',n)');
end;
plot([0 2],[3 3],':');
legend(legend_string',2);
text(0.2,3.6,'{\bf3dB}');
title('Butterworth lowpass filter response');
xlabel('Normalized frequency {\Omega}');
ylabel('Insertion loss, dB');
%print -deps 'fig5_16.eps'   % if uncommented -> saves a copy of plot in EPS format

