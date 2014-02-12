%带通信号经过带通系统的等效基带表示，sig_bandpass.m
clear all;
close all;
dt = 0.01;
t = 0:dt:5;

s1 = exp(-t).*cos(20*pi*t);          %输入信号
[f1 s1f]= T2F(t,s1);                 %输入信号的频谱
s1_lowpass = hilbert(s1).*exp(-j*2*pi*10*t);   %输入信号的等效基带信号
[f2 s2f]=T2F(t,s1_lowpass);          %输入等效基带信号的频谱

h2f = zeros(1,length(s2f));
[a b]=find( abs(s1f)==max(abs(s1f)) ); %找到带通信号的中心频率
h2f( 201-25:201+25 )= 1;
h2f( 301-25:301+25) = 1;
h2f = h2f.*exp(-j*2*pi*f2);           %加入线性相位，

[t1 h1] = F2T(f2,h2f);                %带通系统的冲激响应
h1_lowpass = hilbert(h1).*exp(-j*2*pi*10*t1); %等效基带系统的冲激响应

figure(1)
subplot(521);
plot(t,s1);
xlabel('t'); ylabel('s1(t)'); title('带通信号');
subplot(523);
plot(f1,abs(s1f));
xlabel('f'); ylabel('|S1(f)|'); title('带通信号幅度谱');
subplot(522)
plot(t,real(s1_lowpass));
xlabel('t');ylabel('Re[s_l(t)]');title('等效基带信号的实部');
subplot(524)
plot(f2,abs(s2f));
xlabel('f');ylabel('|S_l(f)|');title('等效基带信号的幅度谱');
%画带通系统及其等效基带的图
subplot(525)
plot(f2,abs(h2f));
xlabel('f');ylabel('|H(f)|');title('带通系统的传输响应幅度谱');
subplot(527)
plot(t1,h1);
xlabel('t');ylabel('h(t)');title('带通系统的冲激响应');

subplot(526)
[f3 hlf]=T2F(t1,h1_lowpass);
plot(f3,abs(hlf));
xlabel('f');ylabel('|H_l(f)|');title('带通系统的等效基带幅度谱');

subplot(528)
plot(t1,h1_lowpass);
xlabel('t');ylabel('h_l(t)');title('带通系统的等效基带冲激响应');

%画出带通信号经过带通系统的响应 及 等效基带信号经过等效基带系统的响应
tt = 0:dt:t1(end)+t(end);
yt = conv(s1,h1);

subplot(529)
plot(tt,yt);
xlabel('t');ylabel('y(t)');title('带通信号与带通系统响应的卷积')

ytl = conv(s1_lowpass,h1_lowpass).*exp(j*2*pi*10*tt);
subplot(5,2,10)
plot(tt,real(yt));
xlabel('t');ylabel('y_l(t)cos(20*pi*t');
title('等效基带与等效基带系统响应的卷积×中心频率载波')

