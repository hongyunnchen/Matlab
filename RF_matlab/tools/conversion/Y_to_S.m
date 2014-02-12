function S=Y_to_S(y_param,Z0);

y11=y_param(1,1)*Z0;
y12=y_param(1,2)*Z0;
y21=y_param(2,1)*Z0;
y22=y_param(2,2)*Z0;

delta=(y11+1)*(y22+1)-y12*y21;

s11=(1-y11)*(1+y22)+y12*y21;
s12=-2*y12;
s21=-2*y21;
s22=(1+y11)*(1-y22)+y12*y21;

S=[s11,s12;s21,s22]/delta;
