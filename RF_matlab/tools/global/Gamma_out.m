function Gout=Gamma_out(s_param, Gs);

s11=s_param(1,1);
s12=s_param(1,2);
s21=s_param(2,1);
s22=s_param(2,2);

Gout=s22+(s21*s12*Gs)/(1-s11*Gs);