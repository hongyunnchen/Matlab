function s_ArcB(B,G1,G2)
%
%   This function plots an arc along the constant susceptance (B)
%   circle in the Smith Chart. The arc is plotted between the 
%   values of conductance G1 and G2.
%
%   It is assume that global variable Z0 has 
%   already been set (see Set_Z0 function)
%
%   usage: s_ArcB(B,R1,R2)
%                 | |  | 
%                 | |  +----- final value of conductance
%                 | |
%                 | +-------- starting value of conductance
%                 |
%                 +---------- susceptance along which an arc is plotted
%
%
%   Copyright (c) 1999 by P.Bretchko and R.Ludwig
%   "RF Circuit Design: Theory and Practice"
%
global Z0

hold on;
color='b';

b=B*Z0;

xc=-1;       % x position of the center
yc=-1/b;     % y position of the center
rd=1/abs(b); % radius of the circle

g1=G1*Z0;
g2=G2*Z0;

Gamma1=(1-g1-j*b)/(1+g1+j*b);
alpha1=atan2(imag(Gamma1)-yc,real(Gamma1)-xc);

Gamma2=(1-g2-j*b)/(1+g2+j*b);
alpha2=atan2(imag(Gamma2)-yc,real(Gamma2)-xc);

alpha=alpha1:((alpha2-alpha1)/100):alpha2;
plot(xc+rd*cos(alpha),yc+rd*sin(alpha),color,'LineWidth',2);

hold off;
