function [s_param,L,C,description]=find_matching(Z0,G_load,freq)

zL=(1+G_load)/(1-G_load);

r=real(zL);
x=imag(zL);
g=real(1/zL);
b=imag(1/zL);

description='nothing';
C=-1;
L=-1;
s11=0;
s22=0;
s21=1;
s_param=[s11,s21;s21,s22];

if r==1 & x>0
   description='series C';
   C=1/(Z0*2*pi*freq*abs(x));
   L=-1;
   s11=-j*x/(2-j*x);
   s22=s11;
   s21=2/(2-j*x);
   s_param=[s11,s21;s21,s22];
elseif r==1 & x<0
   description='series L';
   C=-1;
   L=Z0*abs(x)/(2*pi*freq);
   s11=-j*x/(2-j*x);
   s22=s11;
   s21=2/(2-j*x);
   s_param=[s11,s21;s21,s22];
elseif g==1 & b>0
   description='shunt L';
   C=-1;
   L=Z0/(2*pi*freq*abs(b));
   y=1-j*b;
   s11=(1-y)/(1+y);
   s22=s11;
   s21=1;
   s_param=[s11,s21;s21,s22];
elseif g==1 & b<0
   description='shunt C';
   C=abs(b)/(Z0*2*pi*freq);
   L=-1;
   y=1-j*b;
   s11=(1-y)/(1+y);
   s22=s11;
   s21=1;
   s_param=[s11,s21;s21,s22];
elseif r>1 | (r<1 & g<1 & x>0)
   description='shunt C, series L';
   xl=sqrt((1-g)/g);
   yc=sqrt((1-g)*g)-b;
   L=Z0*xl/(2*pi*freq);
   C=yc/(2*pi*freq*Z0);
   y=yc;
   x=xl;
   s_param=Z_to_S([j*x-j/y,-j/y;-j/y,-j/y]);
elseif r>1 | (r<1 & g<1 & x<0)
   description='shunt L, series C';
   yl=sqrt((1-g)*g)+b;
   xc=sqrt((1-g)/g);
   C=1/(Z0*2*pi*freq*xc);
   L=Z0/(2*pi*freq*yl);
   y=-yl;
   x=-xc;
   s_param=Z_to_S([j*x-j/y,-j/y;-j/y,-j/y]);
elseif g>1 | (r<1 & g<1 & x<0)
   description='series L, shunt C';
   yc=sqrt((1-r)/r);
   xl=sqrt((1-r)*r)-x;
   L=Z0*xl/(2*pi*freq);
   C=yc/(2*pi*freq*Z0);
   y=yc;
   x=xl;
   s_param=Z_to_S([-j/y,-j/y;-j/y,j*x-j/y]);
elseif g>1 | (r<1 & g<1 & x>0)
   description='series C, shunt L';
   yl=sqrt((1-r)/r);
   xc=sqrt((1-r)*r)+x;
   C=1/(Z0*2*pi*freq*xc);
   L=Z0/(2*pi*freq*yl);
   y=-yl;
   x=-xc;
   s_param=Z_to_S([-j/y,-j/y;-j/y,j*x-j/y]);
end;

