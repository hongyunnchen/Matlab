% ����e2.1
% ���������źţ���������չ��,fb_jinshi.m
% �����ź�
% ��֪������Fn::�����źŵĸ���Ҷ����

close all;
clear all;
N=100;    %ȡչ��ʽ������Ϊ2N��1��
N_sample=128; %Ϊ�˻������Σ�����ÿ�����ڵĲ�������

T=1;		%����Ϊ1���źţ���һ��?
fs=1/T;
dt = T/N_sample;


t=0:dt:10*T-dt;
n=-N:N;
Fn = sinc(n/2).*exp(-j*n*pi/2);
% Fn(N+1)=0;	%��Ӧģ���ʱ��0��ֵ
ft = zeros(1,length(t)); %����ʼ��ft

for m=-N:N
	ft = ft + Fn(m+N+1)*exp(j*2*pi*m*fs*t);
end
plot(t,ft)
