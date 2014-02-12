function H=Y_to_H(Y);

y11=Y(1,1);
y12=Y(1,2);
y21=Y(2,1);
y22=Y(2,2);

h11=1;
h12=-y12;
h21=y21;
h22=det(Y);

H=[h11,h12;h21,h22]/y11;

