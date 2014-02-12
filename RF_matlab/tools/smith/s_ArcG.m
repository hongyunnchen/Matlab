function s_ArcG(G,B1,B2)
%
%   This function plots an arc along the constant conductance (G)
%   circle in the Smith Chart. The arc is plotted between the 
%   values of susceptance B1 and B2.
%
%   It is assume that global variable Z0 has 
%   already been set (see Set_Z0 function)
%
%   usage: s_ArcG(G,B1,B2)
%                 | |  | 
%                 | |  +----- final value of susceptance
%                 | |
%                 | +-------- starting value of susceptancee
%                 |
%                 +---------- conductance along which an arc is plotted
%
%
%   Copyright (c) 1999 by P.Bretchko and R.Ludwig
%   "RF Circuit Design: Theory and Practice"
%
global Z0

hold on;
color='b';

g=G*Z0;

xc=1/(g+1)-1;   % x position of the center
rd=1-g/(g+1);    % radius of the circle

b1=B1*Z0;
b2=B2*Z0;

Gamma1=(1-(g+j*b1))/(1+(g+j*b1));
alpha1=atan2(imag(Gamma1),(-xc+real(Gamma1)));

Gamma2=(1-(g+j*b2))/(1+(g+j*b2));
alpha2=atan2(imag(Gamma2),(-xc+real(Gamma2)));

if alpha1*alpha2<0
   if alpha2<0
      alpha=alpha2:((alpha1-alpha2)/100):alpha1;
   else
      alpha=alpha1:((alpha2-alpha1)/100):alpha2;
   end;
else
   if alpha2<alpha1
      alpha=alpha2:((alpha1-alpha2)/100):alpha1;
   else
      alpha=alpha1:((alpha2-alpha1)/100):alpha2;
   end;
end;

plot(xc+rd*cos(alpha),rd*sin(alpha),color,'LineWidth',2);

hold off;
