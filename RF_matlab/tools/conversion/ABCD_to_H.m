function H=ABCD_to_H(abcd_param);

a=abcd_param(1,1);
b=abcd_param(1,2);
c=abcd_param(2,1);
d=abcd_param(2,2);

h11=b;
h12=det(abcd_param);
h21=-1;
h22=c;

H=[h11,h12;h21,h22]/d;
