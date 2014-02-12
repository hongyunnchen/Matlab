%
%   In this example we investigate the stability of a
%   BJT in common-base configuration as a function of
%   the base inductance
% 
%   Copyright (c) 1999 by P.Bretchko and R.Ludwig
%   "RF Circuit Design: Theory and Practice"
%

close all; % close all opened graphs
clear all; % clear all variables
figure;

Z0=50;

% oscillation frequency
f=2e9;
w=2*pi*f;

% transistor S-parameters at oscillation frequency
s_tr=[0.94*exp(j*174/180*pi),0.013*exp(-j*98/180*pi);1.9*exp(-j*28/180*pi),1.01*exp(-j*17/180*pi)];
s11=s_tr(1,1);
s12=s_tr(1,2);
s21=s_tr(2,1);
s22=s_tr(2,2);

% find the Z-parameters of the transistor
z_tr=S_to_Z(s_tr,Z0);

% attempt to add inductor to base in order to increase instability
L=(0:0.01:2)*1e-9;

Z_L=j*w*L;
z_L=[1,1;1,1];

N=length(L);

% create variables for the S_parameters of the transistor with the inductor
s11=zeros([1 N]);
s12=zeros([1 N]);
s21=zeros([1 N]);
s22=zeros([1 N]);

% Rollett stability factor
K=zeros([1 N]);

for n=1:N
   z_total=z_tr+z_L*Z_L(n);
   s_total=Z_to_S(z_total,Z0);
   s11(n)=s_total(1,1);
   s12(n)=s_total(1,2);
   s21(n)=s_total(2,1);
   s22(n)=s_total(2,2);
   K(n)=(1-abs(s11(n))^2-abs(s22(n))^2+abs(det(s_total))^2)/2/abs(s12(n)*s21(n));
end;

close all;

plot(L/1e-9,K);
title('Stability factor of the transistor in common-base mode vs. base inductance');
xlabel('Base inductance L, nH');
ylabel('Rollett stability factor \itk')
axis([0 2 -1 -0.5]);

%print -deps 'fig10_14.eps'

