%
%   This program computes magnetic field produced
%   by a constant current in the wire as described
%   in Example 2.1
% 
%   Copyright (c) 1999 by P.Bretchko and R.Ludwig
%   "RF Circuit Design: Theory and Practice"
%

clear all; % clear all variables
close all; % close all opened graphs
figure;    % open new graph

% define parameters
I=5;     % electric current flowing through wire [in Amperes] 
a=0.005; % radius of the wire [in meters]
r_max=10*a; % maximum distance from the center of the wire
            % for which the magnetic field will be computer 

N=100;
r=(0:N)/N*r_max;
for k=1:N+1
   if(r(k)<=a)
      H(k)=I*r(k)/(2*pi*a*a); % magnetic field inside of the wire
   else
      H(k)=I/(2*pi*r(k));     % magnetic field outside of the wire
   end;
end;

plot(r*1000,H);
hold on;
plot([a a]*1000,[0 160],'r:');
text(5.2,5,'r = a');

title('Magnetic field distribution vs. distance from the center');
xlabel('Distance from the center of the wire {\itr}, mm');
ylabel('Magnetic field {\itH}, A/m');

% print -deps 'fig2_14.eps' % if uncommented -> saves a copy of plot in EPS format

