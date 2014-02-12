%
%   This file generates the graph of the skin depth
%   in copper (Cu), aluminum (Al), and gold (Au) as
%   a function of operating frequency. 
% 
%   Copyright (c) 1999 by P.Bretchko and R.Ludwig
%   "RF Circuit Design: Theory and Practice"
%

close all; % close all opened graphs
figure;    % open new graph

% define material conductivities
sigma_Cu=64.516e6; % copper
sigma_Al=40e6;     % aluminum
sigma_Au=48.544e6; % gold

% permeability of free space
mu0=4*pi*1e-7;

% define frequency in log scale
N=100;       % number points in the graph
fmin=1e4;    % lower frequency limit
fmax=1e9;    % upper frequency limit
f=fmin*((fmax/fmin).^((0:N)/N)); % compute frequency points on log scale


% compute skin depths
delta_Cu=1./sqrt(pi*f*mu0*sigma_Cu);
delta_Al=1./sqrt(pi*f*mu0*sigma_Al);
delta_Au=1./sqrt(pi*f*mu0*sigma_Au);

% generate graph
semilogx(f,delta_Cu,f,delta_Al,f,delta_Au);
title('Skin depth as a function of frequency');
xlabel('Frequency {\itf}, Hz');
ylabel('Skin depth {\delta}, m');
legend('Cu','Al','Au');
axis([1e4 1e9 0 0.001]);

% print -deps 'fig1_4.eps' % if uncommented -> saves a copy of plot in EPS format
