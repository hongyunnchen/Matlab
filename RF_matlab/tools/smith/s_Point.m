function s_Point(Z)
%
% This function plots a point on the Smith Chart
% It is assume that global variable Z0 has 
% already been set (see Set_Z0)
%
% usage: s_Point(30+j*20)
%
%   Copyright (c) 1999 by P.Bretchko and R.Ludwig
%   "RF Circuit Design: Theory and Practice"
%
global Z0;

hold on;
Gamma=(Z-Z0)/(Z+Z0);
plot(real(Gamma),imag(Gamma),'ro');
hold off;
