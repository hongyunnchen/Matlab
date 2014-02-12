close all;
clear all;

Omega=-1.5:0.01:1.5;
IL=zeros([1 length(Omega)]);


% lowpass filter prototype
for m=1:length(Omega)
   IL(m)=10*log10(1+(1-8*Omega(m)^2+8*Omega(m)^4)^2);
end;

figure;
plot(Omega,IL);
axis([-2 2 0 30]);
print -deps 'fig5_23a.eps'


%lowpass filter omega_real=Omega*omega_c
clear all;
omega_c=2*pi;  % 1GHz
omega_real=0:0.01:2*omega_c;

for m=1:length(omega_real)
   omega=omega_real(m)/omega_c;
   IL(m)=10*log10(1+(1-8*omega^2+8*omega^4)^2);
end;

figure;
plot(omega_real/(2*pi),IL);
axis([0 omega_c/pi 0 30]);
print -deps 'fig5_23b.eps'


%highpass filter omega_real=-omega_c/Omega
clear all;
omega_c=2*pi;  % 1GHz
omega_real_max=2*omega_c;
omega_real=0.01:0.1:omega_real_max;

for m=1:length(omega_real)
   omega=-omega_c/omega_real(m);
   IL(m)=10*log10(1+(1-8*omega^2+8*omega^4)^2);
end;

figure;
plot(omega_real/(2*pi),IL);
axis([0 omega_real_max/(2*pi) 0 30]);
print -deps 'fig5_23c.eps'


%bandpass filter
clear all;
omega_U=1.3*(2*pi);  % 1.3GHz
omega_L=0.7*(2*pi);  % 0.7GHz
omega_c=sqrt(omega_U*omega_L);
omega_real_max=2*(2*pi);
omega_real=0.01:0.1:omega_real_max;

for m=1:length(omega_real)
   omega=omega_c/(omega_U-omega_L)*(omega_real(m)/omega_c-omega_c/omega_real(m));
   IL(m)=10*log10(1+(1-8*omega^2+8*omega^4)^2);
end;

figure;
plot(omega_real/(2*pi),IL);
axis([0 omega_real_max/(2*pi) 0 30]);
print -deps 'fig5_23d.eps'


%bandstop filter
clear all;
omega_U=1.3*(2*pi);  % 1.3GHz
omega_L=0.7*(2*pi);  % 0.7GHz
omega_c=sqrt(omega_U*omega_L);
omega_real_max=2*(2*pi);
omega_real=0.01:0.1:omega_real_max;

for m=1:length(omega_real)
   omega=omega_c/(omega_U-omega_L)*(omega_real(m)/omega_c-omega_c/omega_real(m));
   omega=1/omega;
   IL(m)=10*log10(1+(1-8*omega^2+8*omega^4)^2);
end;

figure;
plot(omega_real/(2*pi),IL);
axis([0 omega_real_max/(2*pi) 0 30]);
%print -deps 'fig5_23e.eps'


