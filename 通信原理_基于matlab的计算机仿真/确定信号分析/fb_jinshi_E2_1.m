% 例子e2.1
% 计算周期信号（方波）的展开,fb_jinshi.m
% 周期信号
% 已知条件：Fn::周期信号的傅里叶级数

close all;
clear all;
N=100;    %取展开式的项数为2N＋1项
N_sample=128; %为了画出波形，设置每个周期的采样点数

T=1;		%周期为1的信号，归一化?
fs=1/T;
dt = T/N_sample;


t=0:dt:10*T-dt;
n=-N:N;
Fn = sinc(n/2).*exp(-j*n*pi/2);
% Fn(N+1)=0;	%对应模拟的时间0的值
ft = zeros(1,length(t)); %　初始化ft

for m=-N:N
	ft = ft + Fn(m+N+1)*exp(j*2*pi*m*fs*t);
end
plot(t,ft)
