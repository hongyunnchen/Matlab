function Add_shunt_inductor(ind)
% this function adds a description of the shunt inductor connected to the
% rest of the network
%
% USAGE:
% Add_shunt_inductor(2.5e-9)
%                      |
%                      +---- inductance (2.5nH)
%

global rf_Network;

rf_Network=cat(2,rf_Network,[1;ind;1;0;0]);
