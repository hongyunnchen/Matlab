function Y=Z_to_Y(Z);

z11=Z(:,1,1);
z12=Z(:,1,2);
z21=Z(:,2,1);
z22=Z(:,2,2);

y11=z22;
y12=-z12;
y21=-z21;
y22=z11;

Y=[y11,y12;y21,y22]/det(Z);

