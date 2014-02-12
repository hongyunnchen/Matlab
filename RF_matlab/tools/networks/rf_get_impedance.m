function Z=rf_get_impedance(freq)
%
% this function computes an inpute impedance of the network stored
% in the global variable rf_Network at given frequency specified by 
% the input parameter freq.
% 
% The description of each element in the network consists of the following
% five fields stored in rf_Network:
% 
% field#  |  field name  |   meaning
% --------+--------------+---------------
%    1    |    element   | describes what element is connected
%         |              | this field can have the following values
%         |              | 0 - constant impedance (e.g. resistor)
%         |              | 1 - inductance
%         |              | 2 - capacitance
%         |              | 3 - transmission line
%         |              | 4 - short-circuit stub
%         |              | 5 - open-circuit stub
% --------+--------------+---------------
%    2    |     value    | value of the element
% --------+--------------+---------------
%    3    | shunt/series | 1=shunt or 0=series connection
% --------+--------------+---------------
%    4    |  frequency   | frequency at which electrical length of the line is specified
% --------+--------------+---------------
%    5    |      Z0      | characteristic line impedance
% --------+--------------+---------------
%

global rf_Network;

NN=size(rf_Network);
Nodes=NN(2);

Z=inf;
if Nodes==0
   return;
end;

f=freq;
w=2*pi*f;

% compute the first element, it can be cap, ind, imp, or stub
element=rf_Network(1,1);
value=rf_Network(2,1);
line_Z0=rf_Network(5,1);
shunt=rf_Network(3,1);
frequency=rf_Network(4,1);

if element==0  % constant impedance
   if shunt==1 % shunt connection
      Z=value;
   end;
elseif element==1  % inductor
   value=j*w*value;
   if shunt==1 % shunt connection
      Z=value;
   end;
elseif element==2  % capacitor
   value=1/(j*w*value);
   if shunt==1 % shunt connection
      Z=value;
   end;
elseif element==4  % sc stub
   theta=value*f/frequency*pi/180;
   Z_stub=j*line_Z0*tan(theta);
   if shunt==1 % shunt connection
      Z=Z_stub;
   end;
elseif element==5  % oc stub
   theta=value*f/frequency*pi/180;
   Z_stub=-j*line_Z0/tan(theta);
   if shunt==1 % shunt connection
      Z=Z_stub;
   end;
end;

if Z~=inf
   for n=2:Nodes
      element=rf_Network(1,n);
      value=rf_Network(2,n);
      line_Z0=rf_Network(5,n);
      shunt=rf_Network(3,n);
      frequency=rf_Network(4,n);
      
      if element==0  % constant impedance
         if shunt==1 % shunt connection
            Z=Z*value/(Z+value);
         else  % series connection
            Z=Z+value;
         end;
      elseif element==1  % inductor
         value=j*w*value;
         if shunt==1 % shunt connection
            Z=Z*value/(Z+value);
         else  % series connection
            Z=Z+value;
         end;
      elseif element==2  % capacitor
         value=1/(j*w*value);
         if shunt==1 % shunt connection
            Z=Z*value/(Z+value);
         else  % series connection
            Z=Z+value;
         end;
      elseif element==3  % line
         Gamma=(Z-line_Z0)/(Z+line_Z0);
         theta=value*f/frequency*pi/180;
         Gamma=Gamma*exp(-2*j*theta);
         Z=line_Z0*(1+Gamma)/(1-Gamma);
      elseif element==4  % sc stub
         theta=value*f/frequency*pi/180;
         Z_stub=j*line_Z0*tan(theta);
         if shunt==1 % shunt connection
            Z=Z*Z_stub/(Z+Z_stub);
         else  % series connection
            Z=Z+Z_stub;
         end;
      elseif element==5  % oc stub
         theta=value*f/frequency*pi/180;
         Z_stub=-j*line_Z0/tan(theta);
         if shunt==1 % shunt connection
            Z=Z*Z_stub/(Z+Z_stub);
         else  % series connection
            Z=Z+Z_stub;
         end;
      end;
   end
end;
