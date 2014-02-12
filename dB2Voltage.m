function [ u_Voltage ] = dB2Voltage( u_dB )
	%该函数用于计算功率dB的值转换为对应电压的幅值系数。
	%输入dB值，返回电压幅值
	% dB=20log(Voltage)
	u_Voltage=10^(u_dB/20)
end
