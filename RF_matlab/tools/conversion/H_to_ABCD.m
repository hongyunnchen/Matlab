function ABCD=H_to_ABCD(H);

dim=size(H);
ABCD=zeros(dim);

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
   
   a=-det(H(:,:,n));
   b=-h11;
   c=-h22;
   d=-1;
   
   ABCD(:,:,n)=[a,b;c,d]/h21;
end;

