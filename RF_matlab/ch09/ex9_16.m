%
%   In this example a broad-band amplifier is designed 
%   using the frequency compensated matching network approach
% 
%   Copyright (c) 1999 by P.Bretchko and R.Ludwig
%   "RF Circuit Design: Theory and Practice"
%
close all; % close all opened graphs
clear all; % clear all variables

sm=smith_chart; % create a Smith Chart

global Z0;
set_Z0(50);

% define the S-parameters for the type AT41410
% all S-parameters are measured at Vce=8V and Ic=10mA.

f=[2:4]*1e9;
s_param=zeros(2,2,length(f));

% f=2GHz
s11=0.61*exp(j*(165)/180*pi);
s21=3.72*exp(j*(59)/180*pi);
s12=0.050*exp(j*(42)/180*pi);
s22=0.45*exp(j*(-48)/180*pi);

s_param(:,:,1)=[s11,s12;s21,s22];

% f=3GHz
s11=0.62*exp(j*(149)/180*pi);
s21=2.56*exp(j*(42)/180*pi);
s12=0.064*exp(j*(50)/180*pi);
s22=0.44*exp(j*(-58)/180*pi);

s_param(:,:,2)=[s11,s12;s21,s22];

% f=4GHz
s11=0.62*exp(j*(130)/180*pi);
s21=1.96*exp(j*(20)/180*pi);
s12=0.086*exp(j*(44)/180*pi);
s22=0.48*exp(j*(-78)/180*pi);

s_param(:,:,3)=[s11,s12;s21,s22];


GLmax=zeros([1 length(f)]);
GSmax=zeros([1 length(f)]);
G0=zeros([1 length(f)]);

for n=1:length(f)
   s=s_param(:,:,n);
   
   % for each frequency check stability
   [K,delta] = K_factor(s)
   s11=s(1,1);
   s12=s(1,2);
   s21=s(2,1);
   s22=s(2,2);
   
   % ... and compute the maximum insertion gain and source and load gains
   G0(n)=abs(s21)^2;
   GSmax(n)=1/(1-abs(s11)^2);
   GLmax(n)=1/(1-abs(s22)^2);
end;
G0_dB=10*log10(G0);

% the desired gain is 7.5+/-0.2 dB
Ggoal_dB=7.5; 
error=0.2;

GS_dB=Ggoal_dB-G0_dB; % gain that has to be obtained through matching

% plot constant source gain circles 
a=(0:360)/180*pi;
color=['r' 'g' 'b'];
for n=1:length(f)
   s=s_param(:,:,n);
   
   s11=s(1,1);
   s12=s(1,2);
   s21=s(2,1);
   s22=s(2,2);
   gs=10.^([GS_dB(n)-error;GS_dB(n)+error]/10)/GSmax(n);
   
   for m=1:length(gs)
      dg=gs(m)*conj(s11)/(1-abs(s11)^2*(1-gs(m)));
      rg=sqrt(1-gs(m))*(1-abs(s11)^2)/(1-abs(s11)^2*(1-gs(m)));
      hold on;
      plot(real(dg)+rg*cos(a),imag(dg)+rg*sin(a),color(n),'linewidth',2);
      if (GS_dB(n)<=0 & m==length(gs)) | (GS_dB(n)>0 & m==1)
         text(real(dg)-0.3,imag(dg)+rg+0.08,...
            strcat('\bfG_S=(',sprintf('%.1g',GS_dB(n)),'\pm',...
            sprintf('%.1g',error),')dB @ ',sprintf('%g',f(n)/1e9),'GHz'));
      end;
   end;
end;

% Plot impedance transformations for proposed matching network
global rf_Network; % define a global variable to store a network description

% define matching network elements
C1=0.95e-12;
C2=0.64e-12;

for n=1:length(f)
   init_network; % initialize network description
   Add_shunt_impedance(Z0);
   Add_series_capacitor(C1);
   Add_shunt_capacitor(C2);
   rf_imp_transform(f(n),sm);
end;

%print -deps 'fig9_21.eps'

