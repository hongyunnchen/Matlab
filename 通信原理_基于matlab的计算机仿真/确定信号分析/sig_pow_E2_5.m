%信号的能量计算或功率计算,sig_pow.m
clear all;
close all;
dt = 0.01;
t = 0:dt:5;
 
s1 = exp(-5*t).*cos(20*pi*t);
s2 = cos(20*pi*t);

E1 = sum(s1.*s1)*dt;                 %s1(t)的信号能量
P2 = sum(s2.*s2)*dt/(length(t)*dt);  %s2(t)的信号功率s

[f1 s1f]= T2F(t,s1);
[f2 s2f]= T2F(t,s2);
 
df = f1(2)-f1(1);
E1_f = sum(abs(s1f).^2)*df;          %s1(t)的能量,用频域方式计算
df = f2(2)-f2(1);
T = t(end);
P2_f = sum(abs(s2f).^2)*df/T;        %s2(t)的功率，用频域方式计算

figure(1)
subplot(211)
plot(t,s1);
xlabel('t'); ylabel('s1(t)'); 
subplot(212)
plot(t,s2)
xlabel('t'); ylabel('s2(t)'); 
