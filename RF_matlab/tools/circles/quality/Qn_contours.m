function Qn_contours(Qn, figure_number)
% Usage: Qn_contours(Qn, figure_number)
%
% Purpose: plots constant nodal quality factor 
%          contours in the Smith Chart
% 
% Input parameters: 
%          Qn - set of nodal quality factors for which
%               contours will be plotted
%          figure_number - optional parameter specifying
%               the reference to the figure containing Smith 
%               Chart. If this parameter is not specified then
%               currently active figure will be used
%
if nargin>1
   figure(figure_number);
end;
hold on;
N=length(Qn);
M=50; % the number of steps
for n=1:N
   r=sqrt(1+1/Qn(n)^2);
   y=1/Qn(n);
   alpha=atan(Qn(n));
   a=(-M:M)/M*alpha;
   plot(r*sin(a),-y+r*cos(a));
   plot(r*sin(a),y-r*cos(a));
end;	