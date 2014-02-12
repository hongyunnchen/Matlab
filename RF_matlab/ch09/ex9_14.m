%
%   In this example we first find the constant operating power gain
%   circle and then map it into the G_S plane where it is plotted 
%   in conjunction with the constant noise circle
% 
%   Copyright (c) 1999 by P.Bretchko and R.Ludwig
%   "RF Circuit Design: Theory and Practice"
%

close all; % close all opened graphs
clear all; % clear all variables

smith_chart; % create a Smith Chart

global Z0;
set_Z0(50);

% define the S-parameters of the transistor
s11=0.3*exp(j*(+30)/180*pi);
s12=0.2*exp(j*(-60)/180*pi);
s21=2.5*exp(j*(-80)/180*pi);
s22=0.2*exp(j*(-15)/180*pi);

% pick the noise parameters of the transistor
Fmin_dB=1.5
Fmin=10^(Fmin_dB/10);
Rn=4;
Gopt=0.5*exp(j*45/180*pi);

s_param=[s11,s12;s21,s22];

% check stability
[K,delta] = K_factor(s_param)

% compute a noise circle
Fk_dB=1.6; % desired noise performance
Fk=10^(Fk_dB/10);

Qk=abs(1+Gopt)^2*(Fk-Fmin)/(4*Rn/Z0) % noise circle parameter
dfk=Gopt/(1+Qk); % circle center location
rfk=sqrt((1-abs(Gopt)^2)*Qk+Qk^2)/(1+Qk) % circle radius

%plot a noise circle
a=[0:360]/180*pi;
hold on;
plot(real(dfk)+rfk*cos(a),imag(dfk)+rfk*sin(a),'b','linewidth',2);
text(real(dfk)-0.1,imag(dfk)+rfk+0.08,...
   strcat('\bfF_k=',sprintf('%g',Fk_dB),'dB'));
% plot optimal reflection coefficient
plot(real(Gopt),imag(Gopt),'bo');
text(real(Gopt)+0.05,imag(Gopt)+0.05,'\bf\Gamma_{opt}');
text(real(Gopt)+0.05,imag(Gopt)-0.05,...
   strcat('\bfF_{min}=',sprintf('%g',Fmin_dB),'dB'));

% specify the desired gain
G_goal_dB=8;
G_goal=10^(G_goal_dB/10);

% find the constant operating power gain circles
delta=det(s_param);
go=G_goal/abs(s21)^2; % normalized the gain
dgo=go*conj(s22-delta*conj(s11))/(1+go*(abs(s22)^2-abs(delta)^2)); % center

rgo=sqrt(1-2*K*go*abs(s12*s21)+go^2*abs(s12*s21)^2);
rgo=rgo/abs(1+go*(abs(s22)^2-abs(delta)^2)); % radius

% map a constant gain circle into the Gs plane
rgs=rgo*abs(s12*s21/(abs(1-s22*dgo)^2-rgo^2*abs(s22)^2));
dgs=((1-s22*dgo)*conj(s11-delta*dgo)-rgo^2*conj(delta)*s22)/(abs(1-s22*dgo)^2-rgo^2*abs(s22)^2);

% plot a constant gain circle in the Smith Chart
hold on;
plot(real(dgs)+rgs*cos(a),imag(dgs)+rgs*sin(a),'r','linewidth',2);
text(real(dgs)-0.1,imag(dgs)-rgs-0.05,...
   strcat('\bfG=',sprintf('%g',G_goal_dB),'dB'));

%print -deps 'fig9_17.eps'

% choose a source reflection coefficient Gs
Gs=dgs+j*rgs;
plot(real(Gs), imag(Gs), 'ro');
text(real(Gs)-0.05,imag(Gs)+0.08,'\bf\Gamma_S');

% find the actual noise figure
F=Fmin+4*Rn/Z0*abs(Gs-Gopt)^2/(1-abs(Gs)^2)/abs(1+Gopt)^2;
% print out the actual noise figure
Actual_F_dB=10*log10(F)



