%
%   This program generates a plot of efficiency
%   as a function of the conduction angle
% 
%   Copyright (c) 1999 by P.Bretchko and R.Ludwig
%   "RF Circuit Design: Theory and Practice"
%

close all; % close all opened graphs
clear all; % clear all variables

theta=(1:1:360)/180*pi; % define conduction angle

% compute efficiency
nu=-1/2*(theta-sin(theta))./(theta.*cos(theta/2)-2*sin(theta/2)); 

plot(theta/pi*180,nu*100,'r','linewidth',2);
hold on;
plot([0 180],[pi/4*100 pi/4*100],'b:');
plot([180 180],[0 pi/4*100],'b:');
plot(180,pi/4*100,'bo');
plot(360,50,'bo');

axis([0 360 50 100]);
title('Maximum theoretical efficiency of the amplifier');
xlabel('Conduction angle \Theta_0, deg.');
ylabel('Efficiency \eta, %');

text(25,80,'\eta=78.5%');
text(185,55,'\Theta_0=180\circ');
text(130,90,'\bfClass C');
text(190,80,'\bfClass B');
text(240,70,'\bfClass AB');
text(340,52,'\bfClass A');

% print -deps 'fig8_31.eps'