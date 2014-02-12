function S=Z_to_S(z_param,Z0);

dim=size(z_param);
S=zeros(dim);

if(length(dim)<3)
   N=1;
else
   N=dim(3);
end;

for(n=1:N)
   z11=z_param(1,1,n)/Z0;
   z12=z_param(1,2,n)/Z0;
   z21=z_param(2,1,n)/Z0;
   z22=z_param(2,2,n)/Z0;
   
   delta=(z11+1)*(z22+1)-z12*z21;

   s11=((z11-1)*(z22+1)-z12*z21);
   s12=2*z12;
   s21=2*z21;
   s22=((z11+1)*(z22-1)-z12*z21);
   
   S(:,:,n)=[s11,s12;s21,s22]/delta;
end;



