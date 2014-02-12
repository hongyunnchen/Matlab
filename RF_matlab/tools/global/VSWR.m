function res=VSWR(gamma)
% Usage: res=VSWR(gamma)
%
% Purpose: computes VSWR for give reflection coefficient gamma

if nargin<1
   error('Missing data.');
end;

res=(1+abs(gamma))/(1-abs(gamma));