%��ͨ�źž�����ͨϵͳ�ĵ�Ч������ʾ��sig_bandpass.m
clear all;
close all;
dt = 0.01;
t = 0:dt:5;

s1 = exp(-t).*cos(20*pi*t);          %�����ź�
[f1 s1f]= T2F(t,s1);                 %�����źŵ�Ƶ��
s1_lowpass = hilbert(s1).*exp(-j*2*pi*10*t);   %�����źŵĵ�Ч�����ź�
[f2 s2f]=T2F(t,s1_lowpass);          %�����Ч�����źŵ�Ƶ��

h2f = zeros(1,length(s2f));
[a b]=find( abs(s1f)==max(abs(s1f)) ); %�ҵ���ͨ�źŵ�����Ƶ��
h2f( 201-25:201+25 )= 1;
h2f( 301-25:301+25) = 1;
h2f = h2f.*exp(-j*2*pi*f2);           %����������λ��

[t1 h1] = F2T(f2,h2f);                %��ͨϵͳ�ĳ弤��Ӧ
h1_lowpass = hilbert(h1).*exp(-j*2*pi*10*t1); %��Ч����ϵͳ�ĳ弤��Ӧ

figure(1)
subplot(521);
plot(t,s1);
xlabel('t'); ylabel('s1(t)'); title('��ͨ�ź�');
subplot(523);
plot(f1,abs(s1f));
xlabel('f'); ylabel('|S1(f)|'); title('��ͨ�źŷ�����');
subplot(522)
plot(t,real(s1_lowpass));
xlabel('t');ylabel('Re[s_l(t)]');title('��Ч�����źŵ�ʵ��');
subplot(524)
plot(f2,abs(s2f));
xlabel('f');ylabel('|S_l(f)|');title('��Ч�����źŵķ�����');
%����ͨϵͳ�����Ч������ͼ
subplot(525)
plot(f2,abs(h2f));
xlabel('f');ylabel('|H(f)|');title('��ͨϵͳ�Ĵ�����Ӧ������');
subplot(527)
plot(t1,h1);
xlabel('t');ylabel('h(t)');title('��ͨϵͳ�ĳ弤��Ӧ');

subplot(526)
[f3 hlf]=T2F(t1,h1_lowpass);
plot(f3,abs(hlf));
xlabel('f');ylabel('|H_l(f)|');title('��ͨϵͳ�ĵ�Ч����������');

subplot(528)
plot(t1,h1_lowpass);
xlabel('t');ylabel('h_l(t)');title('��ͨϵͳ�ĵ�Ч�����弤��Ӧ');

%������ͨ�źž�����ͨϵͳ����Ӧ �� ��Ч�����źž�����Ч����ϵͳ����Ӧ
tt = 0:dt:t1(end)+t(end);
yt = conv(s1,h1);

subplot(529)
plot(tt,yt);
xlabel('t');ylabel('y(t)');title('��ͨ�ź����ͨϵͳ��Ӧ�ľ��')

ytl = conv(s1_lowpass,h1_lowpass).*exp(j*2*pi*10*tt);
subplot(5,2,10)
plot(tt,real(yt));
xlabel('t');ylabel('y_l(t)cos(20*pi*t');
title('��Ч�������Ч����ϵͳ��Ӧ�ľ��������Ƶ���ز�')

