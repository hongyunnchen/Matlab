function Add_trans_line(theta_deg,freq_0,line_Z0)
% this function adds a description of the transmission line connected to the
% rest of the network
%
% USAGE:
% Add_trans_line(45, 1e9, 75)
%                 |   |    |
%                 |   |    +---- characteristic impedance of the line
%                 |   |
%                 |   +--------- frequency at which electrical length 
%                 |              of the transmission line is specified
%                 |
%                 +------------- electrical length of the line (beta*length)
%

global rf_Network;

rf_Network=cat(2,rf_Network,[3;theta_deg;0;freq_0;line_Z0]);
