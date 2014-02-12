function s_ArcX(X,R1,R2)
%
%   This function plots an arc along the constant reactance (X)
%   circle in the Smith Chart. The arc is plotted between the 
%   values of resistance R1 and R2.
%
%   It is assume that global variable Z0 has 
%   already been set (see Set_Z0 function)
%
%   usage: s_ArcX(X,R1,R2)
%                 | |  | 
%                 | |  +----- final value of resistance
%                 | |
%                 | +-------- starting value of resistance
%                 |
%                 +---------- reactance along which an arc is plotted
%
%
%   Copyright (c) 1999 by P.Bretchko and R.Ludwig
%   "RF Circuit Design: Theory and Practice"
%
global Z0

hold on;
color='b';

x=X/Z0;

xc=1;        % x position of the center of the X=const circle
yc=1/x;      % y position of the center of the X=const circle
rd=1/abs(x); % radius of the circle of the X=const circle

r1=R1/Z0;
r2=R2/Z0;

Gamma1=(r1+j*x-1)/(r1+j*x+1);
alpha1=atan2(imag(Gamma1)-yc,(real(Gamma1)-xc));

Gamma2=(r2+j*x-1)/(r2+j*x+1);
alpha2=atan2(imag(Gamma2)-yc,(real(Gamma2)-xc));

alpha=alpha1:((alpha2-alpha1)/100):alpha2;
plot(xc+rd*cos(alpha),yc+rd*sin(alpha),color,'LineWidth',2);

hold off;
