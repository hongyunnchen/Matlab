function [ u_Voltage ] = dB2Voltage( u_dB )
	%�ú������ڼ��㹦��dB��ֵת��Ϊ��Ӧ��ѹ�ķ�ֵϵ����
	%����dBֵ�����ص�ѹ��ֵ
	% dB=20log(Voltage)
	u_Voltage=10^(u_dB/20)
end
