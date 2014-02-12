function Z=H_to_Z(H);

dim=size(H);
Z=zeros(dim);

if(length(dim)<3)
   N=1;
else
   N=dim(3);
end;

for(n=1:N)
   h11=H(1,1,n);
   h12=H(1,2,n);
   h21=H(2,1,n);
   h22=H(2,2,n);
   
   z11=det(H(:,:,n));
   z12=h12;
   z21=-h21;
   z22=1;
   
   Z(:,:,n)=[z11,z12;z21,z22]/h22;
end;



