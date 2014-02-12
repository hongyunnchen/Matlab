function H=Z_to_H(Z);

z11=Z(1,1);
z12=Z(1,2);
z21=Z(2,1);
z22=Z(2,2);

h11=det(Z);
h12=z12;
h21=-z21;
h22=1;

H=[h11,h12;h21,h22]/z22;

