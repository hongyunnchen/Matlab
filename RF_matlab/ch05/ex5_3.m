%
%   This file generates the graph for Example 5.3
%   In this example we compare the frequency response of 
%   three types of filters: Chebyshev with 3dB ripples,
%   Butterworth, and linear phase design
% 
%   Copyright (c) 1999 by P.Bretchko and R.Ludwig
%   "RF Circuit Design: Theory and Practice"
%

clear all; % clear all variables
close all; % close all opened graphs
figure;    % open new graph

% define normalized frequency range
w=0.01:0.01:1.5;

% define L and C parameters for the lowpass filter prototypes
L1=[1 1.255  3.3487];
C1=[2 0.5528 0.7117];
L2=[1 0.1922 3.3487];
%   |  |      |
%   |  |      +------ 3dB Chebyshev filter
%   |  |  
%   |  +------------- linear phase filter
%   | 
%   +---------------- Butterworth filter

ZL=1;  % load impedance
V1=1;  % input voltage amplitude

IL=zeros([3 length(w)]);

% lowpass filter prototype
for k=1:3
   ZL1=j*w*L1(k);
   ZC1=1./(j*w*C1(k));
   ZL2=j*w*L2(k);
   
   Z1=ZL2+ZL;
   Z2=Z1.*ZC1./(Z1+ZC1);
   Z3=1+Z2+ZL1;
   
   % compute voltages using the voltage divider rule
   V_internal=Z2./Z3*V1;
   V2=ZL./Z1.*V_internal;
   
   Gain=2*V2/V1;
   IL(k,:)=-20*log10(abs(Gain)); % insertion loss
end;

plot(w,IL(1,:),w,IL(2,:),w,IL(3,:));
axis([0 1.5 0 12]);
title('Frequency response of three types of filters');
xlabel('Normalized frequency \Omega');
ylabel('Insertion loss, dB');
legend('Butterworth', 'Linear phase', '3dB Chebyshev',2);
hold on;
plot([0 1],[3 3],'b:',[1 1],[0 3],'b:');
text(0.1,3.2,'{\bf3db}');
%print -deps 'fig5_23.eps'
