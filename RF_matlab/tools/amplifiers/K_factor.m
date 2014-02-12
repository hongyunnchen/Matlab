function [k,delta] = K_factor(s_param)
% Usage: [k,delta] = K_factor(s_param)
%
% Purpose: returns k factor for a given s-parameter matrix
%          if k>1 and delta<1 then circuit is uncoditionally stable
%          otherwise circuit might be unstable

s11=s_param(1,1);
s12=s_param(1,2);
s21=s_param(2,1);
s22=s_param(2,2);

delta=abs(det(s_param));

k=(1-abs(s11)^2-abs(s22)^2+delta^2)./(2*abs(s12.*s21));
