function ABCD=Y_to_ABCD(Y);

y11=Y(1,1);
y12=Y(1,2);
y21=Y(2,1);
y22=Y(2,2);

a=-y22;
b=-1;
c=-det(Y);
d=-y11;

ABCD=[a,b;c,d]/y21;

