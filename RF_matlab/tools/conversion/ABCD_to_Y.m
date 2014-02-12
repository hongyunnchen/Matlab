function Y=ABCD_to_Y(abcd_param);

a=abcd_param(1,1);
b=abcd_param(1,2);
c=abcd_param(2,1);
d=abcd_param(2,2);

y11=d;
y12=-det(abcd_param);
y21=-1;
y22=a;

Y=[y11,y12;y21,y22]/b;
