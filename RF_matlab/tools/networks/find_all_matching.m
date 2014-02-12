function [s_param,L,C,description,Number_of_networks]=find_all_matching(Z0,G_load,freq)

zL=(1+G_load)/(1-G_load);

r=real(zL);
x=imag(zL);
g=real(1/zL);
b=imag(1/zL);

% first we count the number of possible networks
N=0;
if r==1 & x==0
   N=N+1;
end;
if r==1 & x>0
   N=N+1;
end;
if r==1 & x<0
   N=N+1;
end;
if g==1 & b>0
   N=N+1;
end;
if g==1 & b<0
   N=N+1;
end;
if r>1 | (r<1 & g<1 & x>0)
   N=N+1;
end;
if r>1 | (r<1 & g<1 & x<0)
   N=N+1;
end;
if g>1 | (r<1 & g<1 & x<0)
   N=N+1;
end;
if g>1 | (r<1 & g<1 & x>0)
   N=N+1;
end;

Number_of_networks=N;

N=0;
if r==1 & x==0
   N=N+1;
   description(N,:)='nothing          ';
   C(N)=-1;
   L(N)=-1;
   s11=0;
   s22=0;
   s21=1;
   s_param(N,:,:)=[s11,s21;s21,s22];
end;
if r==1 & x>0
   N=N+1;
   description(N,:)='series C         ';
   C(N)=1/(Z0*2*pi*freq*abs(x));
   L(N)=-1;
   s11=-j*x/(2-j*x);
   s22=s11;
   s21=2/(2-j*x);
   s_param(N,:,:)=[s11,s21;s21,s22];
end;
if r==1 & x<0
   N=N+1;
   description(N,:)='series L         ';
   C(N)=-1;
   L(N)=Z0*abs(x)/(2*pi*freq);
   s11=-j*x/(2-j*x);
   s22=s11;
   s21=2/(2-j*x);
   s_param(N,:,:)=[s11,s21;s21,s22];
end;
if g==1 & b>0
   N=N+1;
   description(N,:)='shunt L          ';
   C(N)=-1;
   L(N)=Z0/(2*pi*freq*abs(b));
   y=1-j*b;
   s11=(1-y)/(1+y);
   s22=s11;
   s21=1;
   s_param(N,:,:)=[s11,s21;s21,s22];
end;
if g==1 & b<0
   N=N+1;
   description(N,:)='shunt C          ';
   C(N)=abs(b)/(Z0*2*pi*freq);
   L(N)=-1;
   y=1-j*b;
   s11=(1-y)/(1+y);
   s22=s11;
   s21=1;
   s_param(N,:,:)=[s11,s21;s21,s22];
end;
if r>1 | (r<1 & g<1 & x>0)
   N=N+1;
   description(N,:)='shunt C, series L';
   xl=sqrt((1-g)/g);
   yc=sqrt((1-g)*g)-b;
   L(N)=Z0*xl/(2*pi*freq);
   C(N)=yc/(2*pi*freq*Z0);
   y=yc;
   x=xl;
   s_param(N,:,:)=Z_to_S([j*x-j/y,-j/y;-j/y,-j/y]*Z0,Z0);
end;
if r>1 | (r<1 & g<1 & x<0)
   N=N+1;
   description(N,:)='shunt L, series C';
   yl=sqrt((1-g)*g)+b;
   xc=sqrt((1-g)/g);
   C(N)=1/(Z0*2*pi*freq*xc);
   L(N)=Z0/(2*pi*freq*yl);
   y=-yl;
   x=-xc;
   s_param(N,:,:)=Z_to_S([j*x-j/y,-j/y;-j/y,-j/y]*Z0,Z0);
end;
if g>1 | (r<1 & g<1 & x<0)
   N=N+1;
   description(N,:)='series L, shunt C';
   yc=sqrt((1-r)/r);
   xl=sqrt((1-r)*r)-x;
   L(N)=Z0*xl/(2*pi*freq);
   C(N)=yc/(2*pi*freq*Z0);
   y=yc;
   x=xl;
   s_param(N,:,:)=Z_to_S([-j/y,-j/y;-j/y,j*x-j/y]*Z0,Z0);
end;
if g>1 | (r<1 & g<1 & x>0)
   N=N+1;
   description(N,:)='series C, shunt L';
   yl=sqrt((1-r)/r);
   xc=sqrt((1-r)*r)+x;
   C(N)=1/(Z0*2*pi*freq*xc);
   L(N)=Z0/(2*pi*freq*yl);
   y=-yl;
   x=-xc;
   s_param(N,:,:)=Z_to_S([-j/y,-j/y;-j/y,j*x-j/y]*Z0,Z0);
end;

