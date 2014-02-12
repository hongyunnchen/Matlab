function [Gamma_s, Gamma_l, gain]=compl_conj(s_param)
% Usage: [Gamma_s, Gamma_l, gain]=compl_conj(s_param)
%
% Purpose: computes source and load reflection coefficients 
%          for maximum (det<1) or minimum (det>1) gain in bilateral case
%
% Parameters: 
%            s_param - s-parameter matrix
%
% Output parameters:
%            Source (Gamma_s) and load (Gamma_l) reflection coefficients
%            gain will indicate either 'min' for minimum gain, 'max' for maximum gain
%            or 'unstable' for unstable case where simultaneous conjugate match does not exist

if nargin<1
   error('Missing data.');
end;

s11=s_param(1,1);
s12=s_param(1,2);
s21=s_param(2,1);
s22=s_param(2,2);

delta=det(s_param);

B1=1+abs(s11)^2-abs(s22)^2-abs(delta)^2;
B2=1+abs(s22)^2-abs(s11)^2-abs(delta)^2;

C1=s11-delta*conj(s22);
C2=s22-delta*conj(s11);

[K,d]=K_factor(s_param);
if(K>1)
   if d<1
      Gamma_s=(B1-sqrt(B1^2-4*abs(C1)^2))/(2*C1);
      Gamma_l=(B2-sqrt(B2^2-4*abs(C2)^2))/(2*C2);
      gain='max';
   else
      Gamma_s=(B1+sqrt(B1^2-4*abs(C1)^2))/(2*C1);
      Gamma_l=(B2+sqrt(B2^2-4*abs(C2)^2))/(2*C2);
      gain='min';
   end;
else
   Gamma_s=-1;
   Gamma_l=-1;
   gain='unstable';
end;


