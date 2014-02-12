%
%   This program plots Si, Ge, and GaAs conductivities
%   as a function of temperature as described in Example 6.1
% 
%   Copyright (c) 1999 by P.Bretchko and R.Ludwig
%   "RF Circuit Design: Theory and Practice"
%

close all; % close all opened graphs
clear all; % clear all variables
figure;    % open new graph

% define physical constants
q=1.60218e-19; % electron charge
k=1.38066e-23; % Boltzmann's constant

% define material properties
Nc_300=[1.04e19 2.8e19  4.7e17]; % effective carrier concentration 
                                 % in conduction band at T=300K
Nv_300=[6e18    1.04e19 7e18];   % effective carrier concentration 
                                 % in valence band at T=300K
mu_n=  [3900    1500    8500];   % electron mobility
mu_p=  [1900    450     400];    % hole mobility
Wg=    [0.66    1.12    1.424];  % band-gap energy in eV
%        |       |       |
%        |       |       +-------- GaAs
%        |       | 
%        |       +---------------- Si
%        |       
%        +------------------------ Ge

T0=273;
T=-50:250; % temperature range in Centigrade

sigma=zeros([3 length(T)]);

for s=1:3  % loop through all semiconductor materials
   Nc=Nc_300(s)*((T+T0)/300).^(3/2);
   Nv=Nv_300(s)*((T+T0)/300).^(3/2);
   sigma(s,:)=q*sqrt(Nc.*Nv).*exp(-Wg(s)./(2*k*(T+T0)/q))*(mu_n(s)+mu_p(s));
end;

semilogy(T,sigma(1,:),T,sigma(2,:),T,sigma(3,:));
legend('Ge','Si','GaAs',2);
title('Conductivity of semiconductor at different temperatures');
xlabel('Temperature, {\circ}C');
ylabel('Conductivity \sigma, \Omega^{-1}cm^{-1}');

%print -deps 'fig6_2.eps'
