function Z=Y_to_Z(Y);

y11=Y(1,1);
y12=Y(1,2);
y21=Y(2,1);
y22=Y(2,2);

z11=y22;
z12=-y12;
z21=-y21;
z22=y11;

Z=[z11,z12;z21,z22]/det(Y);

