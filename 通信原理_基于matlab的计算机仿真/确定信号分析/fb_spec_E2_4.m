%方波的傅氏变换, fb_spec.m
clear all;close all;
T=1;
N_sample = 1280;
dt=T/N_sample;

t=0:dt:T-dt;
st=[ones(1,N_sample/2), -ones(1,N_sample/2)];  %方波一个周期
subplot(211);
plot(t,st);
axis([0 1 -2 2]);
xlabel('t'); ylabel('s(t)');
subplot(212);
[f sf]=T2F(t,st);                               %方波频谱
plot(f,abs(sf)); hold on;
axis([-10 10 0 1]);
xlabel('f');ylabel('|S(f)|');
%根据傅氏变换计算得到的信号频谱相应位置的抽样值
sff= T^2*j*pi*f*0.5.*exp(-j*2*pi*f*T).*sinc(f*T*0.5).*sinc(f*T*0.5);
plot(f,abs(sff),'r-')

