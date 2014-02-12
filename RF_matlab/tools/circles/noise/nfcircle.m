function nfcicle(GMN, NFMIN, NF, NFi, line_style)
% Usage: nfcicle(GMN, NFMIN, NF, NFi, line_style)
%
% Purpose: plots noise figure circles
%
% Parameters: 
%            GMN - optimum input reflection coefficient
%            NFMIN - minimum noise figure
%            NF - noise figure at zero source reflection coefficient   
%            NFi - required noise figure circles (have to be greater than NFMIN)
%            line_style - style of the line which will be used for plot
% Output parameter:
%

hold on;

NF=10^(NF/10);
NFMIN=10^(NFMIN/10);
NFi=10.^(NFi/10);
rn=(NF-NFMIN)*(abs(1+GMN)^2)/(4*abs(GMN)^2);

alpha=2*pi*(0:0.01:1);
for NFc=NFi
   Ni=(NFc-NFMIN)/4/rn*abs(1+GMN)^2;
   CFi=GMN/(1+Ni);
   rFi=1/(1+Ni)*sqrt(Ni^2+Ni*(1-abs(GMN)^2));
   if nargin==4
      plot(real(CFi)+rFi*cos(alpha),imag(CFi)+rFi*sin(alpha),'LineWidth',2);
   else
      plot(real(CFi)+rFi*cos(alpha),imag(CFi)+rFi*sin(alpha),line_style,'LineWidth',2);
   end;
end;
   
hold off;
