function side=output_stability(s_param, line_style)
% Usage: side=output_stability(s_param, line_style)
%
% Purpose: plots output stability circle for given s-parameter matrix
%
% Parameters: 
%            s_param - s-parameter matrix
%            line_style - style of the line which will be used for plot
% Output parameter:
%            side=+1 if stable region is inside of the circle
%            side=-1 if stable region is outside of the circle

if nargin==0
   error('Missing S-parameter data.');
end;

hold on;

s11=s_param(1,1);
s12=s_param(1,2);
s21=s_param(2,1);
s22=s_param(2,2);

delta=det(s_param);
rL=abs(s12*s21/(abs(s22)^2-abs(delta)^2));
CL=conj(s22-delta*conj(s11))/(abs(s22)^2-abs(delta)^2);

alpha=2*pi*(0:0.01:1);
if nargin==1
   plot(real(CL)+rL*cos(alpha),imag(CL)+rL*sin(alpha),'LineWidth',2);
else
   plot(real(CL)+rL*cos(alpha),imag(CL)+rL*sin(alpha),line_style,'LineWidth',2);
end;

hold off;

if abs(s11)<1
   if abs(CL)>rL
      side=1;
   else
      side=-1;
   end;
else
   if abs(CL)>rL
      side=-1;
   else
      side=1;
   end;
end;