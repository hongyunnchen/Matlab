function Y=H_to_Y(H);

h11=H(1,1);
h12=H(1,2);
h21=H(2,1);
h22=H(2,2);

y11=1;
y12=-h12;
y21=h21;
y22=det(H);

Y=[y11,y12;y21,y22]/h11;

