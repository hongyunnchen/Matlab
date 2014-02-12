function const_R_circle(R,linespec)
%
%   This function plots a constant resistance circle in the Smith Chart
%
%   It is assume that global variable Z0 has 
%   already been set (see Set_Z0 function)
%
%   usage: const_R_circle(R,linespec)
%                         |  |
%                         |  +------- optional parameter specifying line type
%                         |
%                         +---------- resistance value (not normalized)
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

r=R/Z0;

xc=r/(1+r);   % x position of the center
rd=1/(1+r);    % radius of the circle

a=(0:360)/180*pi;

plot(xc+rd*cos(a),rd*sin(a),color)

