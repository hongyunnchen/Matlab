function [Z,fig_num]=rf_imp_transform(freq, fig_num_in)
%
% this function computes an inpute impedance and plot all 
% impedance transformations in the network which is stored
% in the global variable rf_Network.
% Network is analyzed at given frequency specified by 
% the input parameter freq.
% Outputs of this routine are input impedance and a figure 
% number which contains the Smith Chart with impedance transformations
% if the Smith Chart was specified by fig_num_in, then fig_num=fig_num_in
% 

global Z0;
global rf_Network; % initialize a reference to the global variable
% 
% Global variable rf_Network contain a description of the network.
% The description of each element in the network contains the following
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

NN=size(rf_Network);
Nodes=NN(2); % find out how many elements are in the network

fig_num=-1;  % indication that network is empty
Z=inf;
if Nodes==0 % if there are no elements, then just return.
   return;
end;

f=freq;
w=2*pi*f;

% find out which element is the first
% it can be either capacitor, or inductor, or impedance, or stub
% there is no check performed for illegal combinations, so it is 
% left up to user to worry about the correctness of the description
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

if nargin>1
   fig_num=figure(fig_num_in);
else
   fig_num=smith_chart;
end;
hold on;
s_Point(Z);

if Z~=inf % check that the first element was correct, 
          % i.e., Z was recomputed
   for n=2:Nodes % run through all remaining elements in the network
      % read in the description of the next component
      element=rf_Network(1,n);
      value=rf_Network(2,n);
      line_Z0=rf_Network(5,n);
      shunt=rf_Network(3,n);
      frequency=rf_Network(4,n);
      
      if element==0  % constant impedance 
                     % (here it is considered to be just a resistor)
         if shunt==1 % shunt connection
            G1=real(1/Z);
            B=imag(1/Z);
            Z=1/(1/Z+1/value);
            G2=real(1/Z);
            s_ArcB(B,G1,G2);
            s_Point(Z);
         else  % series connection
            R1=real(1/Z);
            X=imag(1/Z);
            Z=Z+value;
            R2=real(1/Z);
            s_ArcX(X,R1,R2);
            s_Point(Z);
         end;
      elseif element==1  % inductor
         value=j*w*value;
         if shunt==1 % shunt connection
            B1=imag(1/Z);
            G=real(1/Z);
            Z=1/(1/Z+1/value);
            B2=imag(1/Z);
            s_ArcG(G,B1,B2);
            s_Point(Z);
         else  % series connection
            X1=imag(Z);
            RR=real(Z);
            Z=Z+value;
            X2=imag(Z);
            s_ArcR(RR,X1,X2);
            s_Point(Z);
         end;
      elseif element==2  % capacitor
         value=1/(j*w*value);
         if shunt==1 % shunt connection
            B1=imag(1/Z);
            G=real(1/Z);
            Z=Z*value/(Z+value);
            B2=imag(1/Z);
            s_ArcG(G,B1,B2);
            s_Point(Z);
         else  % series connection
            X1=imag(Z);
            RR=real(Z);
            Z=Z+value;
            X2=imag(Z);
            s_ArcR(RR,X1,X2);
            s_Point(Z);
         end;
      elseif element==3  % line
         % here we have to take into account that characteristic
         % line impedance may be different from Z0 for which 
         % the Smith Chart is plotted
         Gamma0=(Z-line_Z0)/(Z+line_Z0);
         Gamma1=(line_Z0-Z0)/(line_Z0+Z0);
         theta=value*f/frequency*pi/180;
         aa=(0:100)/100*theta;
         GG=(Gamma1+Gamma0*exp(-2*j*aa))./(1+Gamma1*Gamma0*exp(-2*j*aa));
         hold on;
         plot(real(GG), imag(GG), 'b', 'linewidth', 2);
         hold off;
         Gamma=Gamma0*exp(-2*j*theta);
         Z=line_Z0*(1+Gamma)/(1-Gamma);
         s_Point(Z);
      elseif element==4  % sc stub
         theta=value*f/frequency*pi/180;
         Z_stub=j*line_Z0*tan(theta);
         if shunt==1 % shunt connection
            B1=imag(1/Z);
            G=real(1/Z);
            Z=1/(1/Z+1/Z_stub);
            B2=imag(1/Z);
            s_ArcG(G,B1,B2);
            s_Point(Z);
         else  % series connection
            X1=imag(Z);
            RR=real(Z);
            Z=Z+Z_stub;
            X2=imag(Z);
            s_ArcR(RR,X1,X2);
            s_Point(Z);
         end;
      elseif element==5  % oc stub
         theta=value*f/frequency*pi/180;
         Z_stub=-j*line_Z0/tan(theta);
         if shunt==1 % shunt connection
            B1=imag(1/Z);
            G=real(1/Z);
            Z=1/(1/Z+1/Z_stub);
            B2=imag(1/Z);
            s_ArcG(G,B1,B2);
            s_Point(Z);
         else  % series connection
            X1=imag(Z);
            RR=real(Z);
            Z=Z+Z_stub;
            X2=imag(Z);
            s_ArcR(RR,X1,X2);
            s_Point(Z);
         end;
      end;
   end
end;
hold off;
