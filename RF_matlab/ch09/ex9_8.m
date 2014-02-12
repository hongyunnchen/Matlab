%
%   In this example we plot the output matching network's
%   constant gain circles as part of the amplifier design 
% 
%   Copyright (c) 1999 by P.Bretchko and R.Ludwig
%   "RF Circuit Design: Theory and Practice"
%

close all; % close all opened graphs
clear all; % clear all variables

smith_chart; % create a Smith Chart

% define the S-parameters of the transistor
s11=0.5*exp(j*(-60)/180*pi);
s12=0.02*exp(j*(-0)/180*pi);
s21=6.5*exp(j*(+115)/180*pi);
s22=0.6*exp(j*(-35)/180*pi);

s_param=[s11,s12;s21,s22];

% check stability
[K,delta] = K_factor(s_param)

% compute the maximum gain
Gs_max=1/(1-abs(s11)^2);
Gl_max=1/(1-abs(s22)^2);
G0=abs(s21)^2;
Gmax=Gs_max*G0*Gl_max;

% print out the maximum gains in dB
Gs_max_dB=10*log10(Gs_max)
Gl_max_dB=10*log10(Gl_max)
G0_dB=10*log10(G0)
Gmax_dB=10*log10(Gmax)


Ggoal_dB=18; % goal gain in dB
Gload_dB=Ggoal_dB-G0_dB-Gs_max_dB % necessary load gain

% find the reflection coefficient for maximum load gain
Gl_opt=conj(s22);

%draw a straight line connecting Gl_opt and the origin
hold on;
plot([0 real(Gl_opt)],[0 imag(Gl_opt)],'b');
plot(real(Gl_opt),imag(Gl_opt),'bo');

% specify the angle for constant gain circles
a=(0:360)/180*pi;

%plot load gain circle
gl=exp([Gload_dB]/10*log(10))/Gl_max;

dg=gl*conj(s22)/(1-abs(s22)^2*(1-gl));
rg=sqrt(1-gl)*(1-abs(s22)^2)/(1-abs(s22)^2*(1-gl));
plot(real(dg)+rg*cos(a),imag(dg)+rg*sin(a),'b','linewidth',2);
text(real(dg)-0.05,imag(dg)+rg+0.05,strcat('\bf',sprintf('%.2gdB',Gload_dB)));

text(real(Gl_opt)-0.05,imag(Gl_opt)-0.06,'\bf\Gamma_{opt}=S_{22}^*');

% print -deps 'fig9_15.eps'


