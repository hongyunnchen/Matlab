%
%   This file generates the graph of the transistor
%   current gain as a function of operating frequency
%   for various values of the feed-back resistor. 
% 
%   Copyright (c) 1999 by P.Bretchko and R.Ludwig
%   "RF Circuit Design: Theory and Practice"
%

clear all; % clear all variables
close all; % close all opened graphs
figure;    % open new graph

% define transistor equivalent circuit parameters
C_be=10e-12;
C_bc=1e-12;
r_be=520;
r_ce=80000;
g_m=0.192;

% define a set of values in Ohms for the feed-back resistor
R_feedback=[10000 1000 500 300 200];

% define the output matching network parameters
L=1e-9;
C=10e-12;

% select input transmission line parameters
l=0.05;       % line length in meters
vp=0.65*3e8;  % phase velocity of the line
Z0=50;        % characteristic line impedance

% define frequency in log scale
N=100;
fmin=1e4;
fmax=0.2e9;
f=fmin*((fmax/fmin).^((0:N)/N));
w=2*pi*f;

temp=1+j*w*(C_be+C_bc)*r_be;
% compute h-parameters of the transistor
h11=r_be./temp;
h12=j*w*C_bc*r_be./temp;
h21=r_be*(g_m+j*w*C_bc)./temp;
h22=1/r_ce+j*w.*C_bc.*(1+g_m*r_be+j*w*C_be*r_be)./temp;

det_h=h11.*h22-h12.*h21;

for k=1:length(R_feedback)
   % get the feed-back resistance
   R=R_feedback(k);
   
   % convert the h-parameters into y-parameters and add the feed-back resistor
   y11=1./h11+1/R;
   y12=-h12./h11-1/R;
   y21=h21./h11-1/R;
   y22=det_h./h11+1/R;
      
   det_y=y11.*y22-y12.*y21;
   
   % convert result into ABCD representation
   ABCD_tr=[-y22./y21;-1./y21;-det_y./y21;-y11./y21];
   
   % find ABCD matrix for the input matching network
   betta=w/vp;
   ABCD_imn=[cos(betta*l);j*Z0*sin(betta*l);j*sin(betta*l)/Z0;cos(betta*l)];
   
   % .... and for output matching network
   Z_L=j*w*L;
   Z_C=1./(j*w*C);
   ABCD_omn=[1+Z_L./Z_C;2*Z_L+Z_L.*Z_L./Z_C;1./Z_C;1+Z_L./Z_C];
   
   % multiply all three ABCD matrices
   [ABCD_temp11,ABCD_temp12,ABCD_temp21,ABCD_temp22]=special_multiply(ABCD_imn,ABCD_tr);
   ABCD_temp=[ABCD_temp11;ABCD_temp12;ABCD_temp21;ABCD_temp22];
   [ABCD_11,ABCD_12,ABCD_21,ABCD_22]=special_multiply(ABCD_temp,ABCD_omn);
      
   
   % plot the current gain (1/D) in dB
   semilogx(f,-20*log10(abs(ABCD_22)));
   hold on;
end;

title('Current gain as a function of frequency');
xlabel('Frequency {\itf}, Hz');
ylabel('Small-signal current gain, dB');

% print -deps 'fig4_13.eps' % save a copy of plot in EPS format

