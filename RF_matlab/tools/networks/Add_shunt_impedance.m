function Add_shunt_impedance(imp)
% this function adds a description of the constant impedance connected to the
% rest of the network in shunt configuration
%
% USAGE:
% Add_shunt_impedance(25+j*30)
%                      |
%                      +---- 25+j*30 Ohm impedance
%
% Add_shunt_impedance(75)
%                      |
%                      +---- 75 Ohm resistor
%

global rf_Network;

rf_Network=cat(2,rf_Network,[0;imp;1;0;0]);
