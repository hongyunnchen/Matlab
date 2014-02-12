%
%   This file generates the graphs of the characteristic 
%   impedance of the microstrip line and its effective dielectric 
%   constant as a function of width-to-height ratio w/h
%   The corresponding figures in the text are 2-20 and 2-21
% 
%   Copyright (c) 1999 by P.Bretchko and R.Ludwig
%   "RF Circuit Design: Theory and Practice"
%

clear all;
close all; % close all opened graphs

eps=[1 2 3 4.6 7 10 12];  % relative dielectric constants of the substrate 
                          % for which graphs will be plotted
                         
% define w/h ratio on a log scale
N=100;    % number of sample points
wh_min=0.1;
wh_max=10;
wh=wh_min*((wh_max/wh_min).^((0:N)/N));

eps_fig=figure;  % open new graph for relative dielectric constant 
Z0_fig=figure;   % open new graph for characteristic impedance

Zf=sqrt(4*pi*1e-7/8.85e-12);

for n=1:length(eps)
   % compute effective dielectric constant
   er=eps(n);
   eps_eff_2_43=(er+1)/2+(er-1)/2*((1+12./wh).^(-0.5)+0.04*(1-wh).^2); % valid for w/h<1
   eps_eff_2_45=(er+1)/2+(er-1)/2*(1+12./wh).^(-0.5);                  % valid for w/h>1
   eps_eff=eps_eff_2_43.*(wh<1)+eps_eff_2_45.*(wh>=1);
   figure(eps_fig);
   semilogx(wh,eps_eff);
   hold on;
   
   % compute characteristic line impedance
   Z0_2_42=Zf./(2*pi*(eps_eff.^0.5)).*log(8./wh+wh/4);       % see equation (2.42)
   Z0_2_44=Zf./(eps_eff.^0.5)./(1.393+wh+2/3*log(wh+1.444)); % see equation (2.44)
   Z0=Z0_2_42.*(wh<1)+Z0_2_44.*(wh>=1);
   figure(Z0_fig);
   loglog(wh,Z0);
   hold on;
end;
figure(eps_fig);
title('Effective dielectric constants for different relative dielectric constants');
xlabel('Line width-to-dielectric thickness ratio, w/d');
ylabel('Effective dielectric constant, {\epsilon_{eff}}');
axis([0.1 10 0 12]);

figure(Z0_fig);
title('Characteristic line impedance for different dielectric constants');
xlabel('Line width-to-dielectric thickness ratio, w/d');
ylabel('Characteristic line impedance Z_0, {\Omega}');
