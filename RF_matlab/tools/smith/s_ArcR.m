function s_ArcR(R,X1,X2)
%
%   This function plots an arc along the constant resistance (R)
%   circle in the Smith Chart. The arc is plotted between the 
%   values of reactances X1 and X2.
%
%   It is assume that global variable Z0 has 
%   already been set (see Set_Z0 function)
%
%   usage: s_ArcR(R,X1,X2)
%                 | |  | 
%                 | |  +----- final value of reactance
%                 | |
%                 | +-------- starting value of reactance
%                 |
%                 +---------- resistance along which an arc is plotted
%
%
%   Copyright (c) 1999 by P.Bretchko and R.Ludwig
%   "RF Circuit Design: Theory and Practice"
%
global Z0

hold on;
color='b';

r=R/Z0;

xc=r/(1+r);   % x position of the center
rd=1/(1+r);    % radius of the circle

% x1 must be greater than x2
if X1>X2
   x1=X1/Z0;
   x2=X2/Z0;
else
   x2=X1/Z0;
   x1=X2/Z0;
end;

Gamma1=(r+j*x1-1)/(r+j*x1+1);
alpha1=atan2(imag(Gamma1),(real(Gamma1)-xc));
if alpha1<0
   alpha1=alpha1+2*pi;
end;

Gamma2=(r+j*x2-1)/(r+j*x2+1);
alpha2=atan2(imag(Gamma2),(real(Gamma2)-xc));
if alpha2<0
   alpha2=alpha2+2*pi;
end;

alpha=alpha1:((alpha2-alpha1)/100):alpha2;
plot(xc+rd*cos(alpha),rd*sin(alpha),color,'LineWidth',2);

hold off;
