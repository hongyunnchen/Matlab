%
%   In this example we plot the constant operating power gain
%   circle and choose a load reflection coefficient G_L.
%   Based on this G_L the input reflection coefficient is computed
% 
%   Copyright (c) 1999 by P.Bretchko and R.Ludwig
%   "RF Circuit Design: Theory and Practice"
%

close all; % close all opened graphs
clear all; % clear all variables

smith_chart; % create a Smith Chart

% define the S-parameters of the transistor
s11=0.3*exp(j*(+30)/180*pi);
s12=0.2*exp(j*(-60)/180*pi);
s21=2.5*exp(j*(-80)/180*pi);
s22=0.2*exp(j*(-15)/180*pi);

s_param=[s11,s12;s21,s22];

% check stability
[K,delta] = K_factor(s_param)

% find the maximum gain
Gmax=abs(s21/s12)*(K-sqrt(K^2-1));

Gmax_dB=10*log10(Gmax)

% specify the target gain
G_goal_dB=8; % would like to build an amplifier with 8dB gain
G_goal=10^(G_goal_dB/10); % convert from dB to normal units

% find constant operating power gain circles
delta=det(s_param);
go=G_goal/abs(s21)^2; % normalized the operating power gain
% find the center of the constant operating power gain circle
dgo=go*conj(s22-delta*conj(s11))/(1+go*(abs(s22)^2-abs(delta)^2));

% find the radius of the circle 
rgo1=sqrt(1-2*K*go*abs(s12*s21)+go^2*abs(s12*s21)^2);
rgo=rgo1/abs(1+go*(abs(s22)^2-abs(delta)^2));

% plot a circle in the Smith Chart
a=(0:360)/180*pi;

hold on;
plot(real(dgo)+rgo*cos(a),imag(dgo)+rgo*sin(a),'r','linewidth',2);
text(real(dgo)-0.1,imag(dgo)+rgo+0.05,strcat('\bf',sprintf('G=%gdB',G_goal_dB)));

% choose the load reflection coefficient
zL=1-j*0.53
GL=(zL-1)/(zL+1);
% ... and plot it in the Smith Chart
plot(real(GL),imag(GL),'bo');
text(real(GL)-0.05,imag(GL)-0.07,'\bf\Gamma_L');

Gin=s11+s12*s21*GL/(1-s22*GL);
Gs=conj(Gin);
Gs_abs=abs(Gs)
Gs_angle=angle(Gs)/pi*180

zs=(1+Gs)/(1-Gs)

%print -deps 'fig9_16.eps'



