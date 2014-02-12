function T=S_to_T(s_param);

s11=s_param(1,1);
s12=s_param(1,2);
s21=s_param(2,1);
s22=s_param(2,2);

T=[1/s21,-s22/s21;s11/s21,s12-s11*s22/s21];