function Add_shunt_oc_stub(theta_deg,freq_0,line_Z0)
% this function adds a description of the open-circuit stub connected to the
% rest of the network in shunt configuration
%
% USAGE:
% Add_shunt_oc_stub(45, 1e9, 75)
%                    |   |    |
%                    |   |    +---- characteristic impedance of the stub
%                    |   |
%                    |   +--------- frequency at which electrical length 
%                    |              of the transmission line is specified
%                    |
%                    +------------- electrical length of the stub (beta*length)
%

global rf_Network;

rf_Network=cat(2,rf_Network,[5;theta_deg;1;freq_0;line_Z0]);
