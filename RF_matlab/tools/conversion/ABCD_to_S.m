function S=ABCD_to_S(abcd_param,Z0);

dim=size(abcd_param);
S=zeros(dim);

if(length(dim)<3)
   N=1;
else
   N=dim(3);
end;

for(n=1:N)
   a=abcd_param(1,1,n);
   b=abcd_param(1,2,n)/Z0;
   c=abcd_param(2,1,n)*Z0;
   d=abcd_param(2,2,n);
   
   delta=a+b+c+d;
   
   s11=a+b-c-d;
   s12=2*(a*d-b*c);
   s21=2;
   s22=-a+b-c+d;
   
   S(:,:,n)=[s11,s12;s21,s22]/delta;
end;

