function Add_shunt_capacitor(cap)
% this function adds a description of the shunt capacitor connected to the
% rest of the network
%
% USAGE:
% Add_shunt_capacitor(2.5e-12)
%                      |
%                      +---- capacitance (2.5pF)
%

global rf_Network;

rf_Network=cat(2,rf_Network,[2;cap;1;0;0]);
