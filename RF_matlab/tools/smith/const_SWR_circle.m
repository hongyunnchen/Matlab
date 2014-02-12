function const_SWR_circle(Z,linespec)
%
%   This function plots a constant SWR circle in the Smith Chart
%
%   It is assume that global variable Z0 has 
%   already been set (see Set_Z0 function)
%
%   usage: const_SWR_circle(Z,linespec)
%                           |  |
%                           |  +------- optional parameter specifying line type
%                           |
%                           +---------- impedance value (not normalized)
%
%   Copyright (c) 1999 by P.Bretchko and R.Ludwig
%   "RF Circuit Design: Theory and Practice"
%
global Z0

hold on;
if nargin>1
   color=linespec;
else
   color='k:';
end;

rd=abs((Z-Z0)/(Z+Z0));    % radius of the circle

a=(0:360)/180*pi;

plot(rd*cos(a),rd*sin(a),color)

