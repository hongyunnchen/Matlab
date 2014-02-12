function Add_series_capacitor(cap)
% this function adds a description of the series capacitor connected to the
% rest of the network
%
% USAGE:
% Add_series_capacitor(2.5e-12)
%                       |
%                       +---- capacitance (2.5pF)
%

global rf_Network;

rf_Network=cat(2,rf_Network,[2;cap;0;0;0]);
