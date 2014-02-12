%
%   In this example we design a GaAs FET oscillator
%   using microstrip matching networks
% 
%   Copyright (c) 1999 by P.Bretchko and R.Ludwig
%   "RF Circuit Design: Theory and Practice"
%

close all; % close all opened graphs
clear all; % clear all variables

global Z0;

% characteristic impedance 
Set_Z0(50);

% desired oscillation frequency
f=10e9;
w=2*pi*f;

% ATF13100 transistor S-parameters at osc. freq. (common gate, Vdg=3V, Vsg=0.65V)
s_tr=[-0.370-j*0.023,0.164+j*0.059;1.279-j*0.484,0.811-j*0.389];
s11=s_tr(1,1);
s12=s_tr(1,2);
s21=s_tr(2,1);
s22=s_tr(2,2);

% find the Z-parameters of the transistor
z_tr=S_to_Z(s_tr,Z0)

% add inductor in gate in order to increase instability

L=(0:0.01:2)*1e-9;

Z_L=j*w*L;
z_L=[1,1;1,1];

N=length(L);

% create variables for S-parameters of transistor with inductor
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

figure;
plot(L/1e-9,K);
title('Stability factor of FET in common-gate configuration vs. gate inductance');
xlabel('Gate inductance L, nH');
ylabel('Rollett stability factor \itk')

% print -deps 'fig10_18.eps'

% plot stability circles without gate inductor
smith_chart;
input_stability(s_tr,'r');
output_stability(s_tr,'b');

% from the graphs we pick L for maximum values of S parameters
L=0.9e-9;

% compute new S-parameters of the transistor
Z_L=j*w*L;
z_total=z_tr+z_L*Z_L;
s_total=Z_to_S(z_total,Z0);
s11=s_total(1,1);
s12=s_total(1,2);
s21=s_total(2,1);
s22=s_total(2,2);

ss=[s11,s12;s21,s22]

% plot stability circles with gate inductor
input_stability(s_total,'r:');
output_stability(s_total,'b:');

