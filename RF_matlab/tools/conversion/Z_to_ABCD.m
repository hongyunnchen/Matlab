function ABCD=Z_to_ABCD(Z);

dim=size(Z);
ABCD=zeros(dim);

if(length(dim)<3)
   N=1;
else
   N=dim(3);
end;

for(n=1:N)
   z11=Z(1,1,n);
   z12=Z(1,2,n);
   z21=Z(2,1,n);
   z22=Z(2,2,n);
   
   a=z11;
   b=det(Z(:,:,n));
   c=1;
   d=z22;
   
   ABCD(:,:,n)=[a,b;c,d]/z21;
end;



