%
%   This file generates the graphs of the characteristic 
%   impedance for the microstrip line of two different 
%   metallization thicknesses
% 
%   Copyright (c) 1999 by P.Bretchko and R.Ludwig
%   "RF Circuit Design: Theory and Practice"
%

clear all;
close all;  % close all opened graphs

er=4.6;     % relative dielectric constant of the substrate 
h=25;       % substrate thickness [in mil]
tt=[0 1.5]; % thickness of the conductor [in mil]

% define w/h ratio in log scale
N=100;
wh_min=0.12;
wh_max=10;
wh_initial=wh_min*((wh_max/wh_min).^((0:N)/N)); % unadjusted w/h ratio

figure;   % open new graph for characteristic impedance

Zf=sqrt(4*pi*1e-7/8.85e-12);

for n=1:length(tt)
   
   t=tt(n);
   
   % adjust w/h ratio due to nonzero conductor thickness
   if t>0
      w=wh_initial*h;
      x=h*(wh>1/(2*pi))+2*pi*w.*(wh<=1/(2*pi));
      w_eff=w+t/pi*(1+log(2*x/t));
      wh=w_eff/h;
   else
      wh=wh_initial;
   end;
   
   % compute effective dielectric constant
   eps_eff_2_43=(er+1)/2+(er-1)/2*((1+12./wh).^(-0.5)+0.04*(1-wh).^2); % valid for w/h<1
   eps_eff_2_45=(er+1)/2+(er-1)/2*(1+12./wh).^(-0.5);                  % valid for w/h>1
   eps_eff=eps_eff_2_43.*(wh<1)+eps_eff_2_45.*(wh>=1);
   
   % compute characteristic line impedance
   Z0_2_42=Zf./(2*pi*(eps_eff.^0.5)).*log(8./wh+wh/4);       % see equation (2.42)
   Z0_2_44=Zf./(eps_eff.^0.5)./(1.393+wh+2/3*log(wh+1.444)); % see equation (2.44)
   Z0=Z0_2_42.*(wh<1)+Z0_2_44.*(wh>=1);
   semilogx(wh_initial,Z0);
   hold on;
end;

title('Characteristic line impedance for different dielectric constants');
xlabel('Line width-to-dielectric thickness ratio, w/d');
ylabel('Characteristic line impedance Z_0, {\Omega}');
axis([0.1 10 0 150]);

