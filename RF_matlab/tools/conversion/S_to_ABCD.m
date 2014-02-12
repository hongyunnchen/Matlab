function ABCD=S_to_ABCD(s_param,Z0);

s11=s_param(1,1);
s12=s_param(1,2);
s21=s_param(2,1);
s22=s_param(2,2);

a=((1+s11)*(1-s22)+s12*s21)/2/s21;
b=((1+s11)*(1+s22)-s12*s21)/2/s21;
c=((1-s11)*(1-s22)-s12*s21)/2/s21;
d=((1-s11)*(1+s22)+s12*s21)/2/s21;

ABCD=[a,b*Z0;c/Z0,d];
