function S=H_to_S(H,Z0);
% converts h-parameters to s-parameters

h11=H(1,1)/Z0;
h12=H(1,2);
h21=H(2,1);
h22=H(2,2)*Z0;

delta=(h11+1)*(h22+1)-h12*h21;

s11=(h11-1)*(h22+1)-h12*h21;
s12=2*h12;
s21=-2*h21;
s22=(1+h11)*(1-h22)+h12*h21;

S=[s11,s12;s21,s22]/delta;

