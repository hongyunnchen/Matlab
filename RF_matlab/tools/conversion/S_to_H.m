function H=S_to_H(s,Z0);
% converts s-parameters to h-parameters

s11=s(1,1);
s12=s(1,2);
s21=s(2,1);
s22=s(2,2);

delta=(1-s11)*(1+s22)+s12*s21;

h11=Z0*((1+s11)*(1+s22)-s12*s21);
h12=2*s12;
h21=-2*s21;
h22=((1-s11)*(1-s22)-s12*s21)/Z0;

H=[h11,h12;h21,h22]/delta;
