function [Gs_max, Gl_max]=const_gain(s_param, source_attn, load_attn)
%
% Usage: [Gs_max, Gl_max]=const_gain(s_param, source_attn, load_attn)
%
% Purpose: plots constant gain circles for given s-parameter matrix assuming unilateral case
%
% Parameters: 
%            s_param - s-parameter matrix
%            source_attn - attenuation on the source side compared to the maximum gain expressed in dB
%            load_attn - attenuation on the load side compared to the maximum gain expressed in dB
% Output parameters:
%            Gs_max - maximum source gain
%            Gl_max - maximum load gain
%
if nargin<3
   error('Missing data.');
end;

hold on;

s11=s_param(1,1);
s12=s_param(1,2);
s21=s_param(2,1);
s22=s_param(2,2);

Gs_max=1/(1-abs(s11)^2);
Gl_max=1/(1-abs(s22)^2);

gs=10.^(-source_attn/10);
gl=10.^(-load_attn/10);

Cgs=(gs.*conj(s11))./(1-abs(s11)^2.*(1-gs));
rgs=sqrt(1-gs).*(1-abs(s11)^2)./(1-abs(s11)^2.*(1-gs));

Cgl=(gl.*conj(s22))./(1-abs(s22)^2.*(1-gl));
rgl=sqrt(1-gl).*(1-abs(s22)^2)./(1-abs(s22)^2.*(1-gl));

alpha_text=82/180*pi;
ct=cos(alpha_text);
st=sin(alpha_text);

alpha=2*pi*(0:0.01:1);
N=length(Cgs);
for n=1:N
   color=[0.5*(1+n/N) 0 0];
   gain=10*log10(Gs_max)-source_attn(n);
   plot(real(Cgs(n))+rgs(n)*cos(alpha),imag(Cgs(n))+rgs(n)*sin(alpha),...
      'LineWidth',2,'color',color);
   text(real(Cgs(n))+rgs(n)*ct,imag(Cgs(n))+rgs(n)*st,num2str(gain,'%.1fdB'), ...
      'horizontalalignment','left','VerticalAlignment','bottom',...
      'color',color);
end;

N=length(Cgl);
for n=1:N
   color=[0 0.5*(1+n/N) 0];
   gain=10*log10(Gl_max)-load_attn(n);
   plot(real(Cgl(n))+rgl(n)*cos(alpha),imag(Cgl(n))+rgl(n)*sin(alpha),...
      'LineWidth',2,'color',color);
   text(real(Cgl(n))+rgl(n)*ct,imag(Cgl(n))+rgl(n)*st,num2str(gain,'%.1fdB'), ...
      'horizontalalignment','left','VerticalAlignment','bottom',...
      'color',color);
end;

hold off;

