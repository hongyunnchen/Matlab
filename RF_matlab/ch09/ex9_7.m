%
%   In this example we plot the input matching network
%   gain circles. Constant gain circles are shown
%   for Gs ranging from -1dB to +2.6dB
% 
%   Copyright (c) 1999 by P.Bretchko and R.Ludwig
%   "RF Circuit Design: Theory and Practice"
%

close all; % close all opened graphs
clear all; % clear all variables

smith_chart; % create a Smith Chart

% define s11 parameter of the transistor
s11=0.7*exp(j*(125)/180*pi);

% compute the maximum gain achievable by the input matching network
Gs_max=1/(1-abs(s11)^2);
Gs_max_dB=10*log10(Gs_max)

% find the reflection coefficient for the maximum gain
Gs_opt=conj(s11);

%draw a straight line connecting Gs_opt and the origin
hold on;
plot([0 real(Gs_opt)],[0 imag(Gs_opt)],'b');
plot(real(Gs_opt),imag(Gs_opt),'bo');

% specify the angle for the constant gain circles
a=(0:360)/180*pi;

%plot source gain circles
gs_db=[-1 0 1 2 2.6]; % range of desired gains
gs=exp(gs_db/10*log(10))/Gs_max; % convert from dB to normal units

for n=1:length(gs)
   dg=gs(n)*conj(s11)/(1-abs(s11)^2*(1-gs(n)));
   rg=sqrt(1-gs(n))*(1-abs(s11)^2)/(1-abs(s11)^2*(1-gs(n)));
   plot(real(dg)+rg*cos(a),imag(dg)+rg*sin(a),'r','linewidth',2);
   text(real(dg)-0.05,imag(dg)+rg+0.05,strcat('\bf',sprintf('%gdB',gs_db(n))));
end;

text(real(Gs_opt)-0.05,imag(Gs_opt)-0.06,'\bf\Gamma_{opt}=S_{11}^*');

% print -deps 'fig9_14.eps'
