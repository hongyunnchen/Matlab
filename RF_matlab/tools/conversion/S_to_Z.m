function Z=S_to_Z(s_param,Z0);

s11=s_param(1,1);
s12=s_param(1,2);
s21=s_param(2,1);
s22=s_param(2,2);

delta=(1-s11)*(1-s22)-s12*s21;

z11=((1+s11)*(1-s22)+s12*s21)/delta;
z12=2*s12/delta;
z21=2*s21/delta;
z22=((1-s11)*(1+s22)+s12*s21)/delta;

Z=[z11,z12;z21,z22]*Z0;
