function Gin=Gamma_in(s_param, GL);

s11=s_param(1,1);
s12=s_param(1,2);
s21=s_param(2,1);
s22=s_param(2,2);

Gin=s11+(s21*s12*GL)/(1-s22*GL);