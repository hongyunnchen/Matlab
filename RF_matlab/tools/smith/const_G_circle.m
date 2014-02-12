function const_G_circle(G,linespec)
%
%   This function plots a constant conductance circle in the Smith Chart
%
%   It is assume that global variable Z0 has 
%   already been set (see Set_Z0 function)
%
%   usage: const_G_circle(G,linespec)
%                         |  |
%                         |  +------- optional parameter specifying line type
%                         |
%                         +---------- conductance value (not normalized)
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

g=G*Z0;

xc=1/(g+1)-1;   % x position of the center
rd=1-g/(g+1);    % radius of the circle

a=(0:360)/180*pi;

plot(xc+rd*cos(a),rd*sin(a),color)

