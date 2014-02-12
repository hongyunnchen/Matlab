function Set_Z0(z0)

%
% this function sets a global variable Z0 which is 
% used for Smith Chart computations
%
% USAGE: Set_Z0(50)
%                |
%                +---- Sets characteristic impedance to 50 Ohm
%
%   Copyright (c) 1999 by P.Bretchko and R.Ludwig
%   "RF Circuit Design: Theory and Practice"
%

global Z0;
Z0=z0;
