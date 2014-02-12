function Y=S_to_Y(s_param,Z0);

s11=s_param(1,1);
s12=s_param(1,2);
s21=s_param(2,1);
s22=s_param(2,2);

delta=(1+s11)*(1+s22)-s12*s21;

y11=((1-s11)*(1+s22)+s12*s21)/delta;
y12=-2*s12/delta;
y21=-2*s21/delta;
y11=((1+s11)*(1-s22)+s12*s21)/delta;

Y=[y11,y12;y21,y22]/Z0;
