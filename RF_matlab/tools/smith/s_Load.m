function s_Load(ZL_in)

%
% This function set a global variable ZL (load impedance)
% to the specified values. It also plots a point on the Smith Chart
% It is assume that global variable Z0 has already been set (see Set_Z0)
%
% usage: s_Load(load_impedance)
%
%   Copyright (c) 1999 by P.Bretchko and R.Ludwig
%   "RF Circuit Design: Theory and Practice"
%


global Z0;
global ZL;

ZL=ZL_in;

hold on;
Gamma=(ZL-Z0)/(ZL+Z0);
plot(real(Gamma),imag(Gamma),'ro');
hold off;