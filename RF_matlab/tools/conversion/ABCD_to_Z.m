function Z=ABCD_to_Z(abcd_param);

dim=size(abcd_param);
Z=zeros(dim);

if(length(dim)<3)
   N=1;
else
   N=dim(3);
end;

for(n=1:N)
   a=abcd_param(1,1,n);
   b=abcd_param(1,2,n);
   c=abcd_param(2,1,n);
   d=abcd_param(2,2,n);
   
   z11=a;
   z12=det(abcd_param(:,:,n));
   z21=1;
   z22=d;
   
   Z(:,:,n)=[z11,z12;z21,z22]/c;
end;
