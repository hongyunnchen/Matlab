%
%   This program computes the small-signal impedance of 
%   a Si-based pn-junction diode
% 
%   Copyright (c) 1999 by P.Bretchko and R.Ludwig
%   "RF Circuit Design: Theory and Practice"
%

close all; % close all opened graphs
clear all; % clear all variables

% first we define all parameters for the transistor and the circuit
Z0=50;   % characteristic imedance of the system

Vcc=3.6;  % power supply voltage
Vce=2;    % collector voltage 
Ic=10e-3; % collector current

T=300;   % ambient temperature (300K)

% transistor parameters (they are very similar to BFG403W)
beta=145;    % current gain
Is=5.5e-18;  % saturation current
VAN= 30;     % forward Early voltage
tau_f=4e-12; % forward transition time
rb=125;      % base resistance
rc=15;       % collector resistance
re=1.5;      % emitter resistance
Lb=1.1e-9;   % base inductance
Lc=1.1e-9;   % collector inductance
Le=0.5e-9;   % emitter inductance
Cjc=16e-15;  % collector junction capacitance at zero applied voltage
mc=0.2;      % collector junction grading coefficient
Cje=37e-15;  % emitter junction capacitance at zero applied voltage
me=0.35;     % emitter junction grading coefficient
phi_be=0.9;  % base-emitter diffusion potential
phi_bc=0.6;  % base-collector diffusion potential
Vbe=phi_be;  % base-emitter voltage

% some physical constants
k=1.38e-23;   % Boltzmann's constant
q=1.6e-19;    % elementary charge
VT=k*T/q;     % thermal potential

% compute the values for the biasing resistors
s=sprintf('\n\nDC biasing parameters\n\n');

Ib=Ic/beta;
s=sprintf('%s  DC base current: Ib=%.2f uA\n',s,Ib/1e-6);

Rc=(Vcc-Vce)/Ic;
s=sprintf('%s  Collector biasing resistor: Rc=%.f Ohm\n',s,Rc);

Rb=(Vcc-Vbe)/Ib;
s=sprintf('%s  Base biasing resistor: Rb=%.f kOhm\n',s,Rb/1e3);

% computing small signal model parameters
s=sprintf('%s\n\nSmall-signal hybrid-pi model parameters\n\n',s);

r_pi=VT/Ib;
s=sprintf('%s  r_pi=%.f Ohm\n',s,r_pi);

r0=VAN/Ic;
s=sprintf('%s  r0=%.f kOhm\n',s,r0/1e3);

gm=beta/r_pi;
s=sprintf('%s  gm=%.f mS\n',s,gm/1e-3);

Vbc=Vbe-Vce;
Cmu=Cjc*(1-Vbc/phi_bc)^(-mc);
s=sprintf('%s\n  Base-collector capacitance: Cmu=%.2f fF\n',s,Cmu/1e-15);

s=sprintf('%s\n  Base-emitter capacitance:\n',s);

% compute equivalent pi capacitance
if(Vbe<0.5*phi_be)
   Cpi_junct=Cje*(1-Vbe/phi_be)^(-me);
else
   C_middle=Cje*0.5^(-me);
   k_middle=1-0.5*me;
   Cpi_junct=C_middle*(k_middle+me*Vbe/phi_be);
end;

s=sprintf('%s      Junction capacitance: Cpi_junct=%.2f fF\n',s,Cpi_junct/1e-15);

Cpi_diff=Is*tau_f/VT*exp(Vbe/VT);
s=sprintf('%s      Differential capacitance: Cpi_diff=%.2f fF\n',s,Cpi_diff/1e-15);

Cpi=Cpi_junct+Cpi_diff;
s=sprintf('%s      Total capacitance: Cpi=%.2f fF\n',s,Cpi/1e-15);

% compute Miller capacitances
C_miller=Cmu*(1+gm*r_pi/(r_pi+rb)*Z0*r0/(r0+rc+Z0));
s=sprintf('%s\n\n  Miller capacitance: C_miller=%.2f fF\n',s,C_miller/1e-15);
C_input=Cpi+C_miller;
s=sprintf('%s  Total input capacitance: C_input=%.2f fF\n',s,C_input/1e-15);

s

%********************************************************
% now we are able to compute the frequency response 
% for Zin, S11, and S21 of the transistor die
%

% define frequency range
f_min=1e6;    % lower limit
f_max=100e9;  % upper limit
N=200;        % number of points in the graph
f=f_min*((f_max/f_min).^((0:N)/N)); % compute frequency points on log scale
w=2*pi*f;  

% compute h-parameters

h11=r_pi./(1+j*w*(Cpi+Cmu)*r_pi);
h12=j*w*Cmu*r_pi./(1+j*w*(Cpi+Cmu)*r_pi);
h21=r_pi*(gm-j*w*Cmu)./(1+j*w*(Cpi+Cmu)*r_pi);
h22=1/r0+j*w*Cmu.*(1+j*w*Cpi*r_pi+gm*r_pi)./(1+j*w*(Cpi+Cmu)*r_pi);

h=zeros(2,2,N+1);

for n=1:N+1
   h(:,:,n)=[h11(n),h12(n);h21(n),h22(n)];
end;

% convert h-parameters of transistor in die into ABCD form
ABCD_die=H_to_ABCD(h);

% find corresponding S and Z-parameters
s_param=ABCD_to_S(ABCD_die,Z0);
z_param=ABCD_to_Z(ABCD_die);

% obtain S11 and S21
dim=size(s_param);
s11=zeros([1 dim(3)]);
s21=zeros([1 dim(3)]);
s11(:)=s_param(1,1,:);
s21(:)=s_param(2,1,:);

% plot S11 on the Smith Chart
m_s11=smith_chart; % create a new figure for the Smith Chart display
hold on;
plot(real(s11),imag(s11),'r','linewidth',2);

% plot S21 on the polar graph
p_s21=figure;  % create polar plot for S21
polar(angle(s21),abs(s21),'r');
hold on;

% extract Z11 and Z22
dim=size(z_param);
z11=zeros([1 dim(3)]);
z22=zeros([1 dim(3)]);
z11(:)=z_param(1,1,:);
z22(:)=z_param(2,2,:);

% plot Z11
m_z11=figure; % create a new graph for Z11
semilogx(f, abs(z11),'r','linewidth',2);
hold on;

% plot Z22
m_z22=figure; % create a new graph for Z22
semilogx(f, abs(z22),'r','linewidth',2);
hold on;

%***************************************************
% next base and collector leads are attached to 
% the transistor die
%

%find ABCD parameters of the base lead
ABCD_base=zeros(2,2,N+1);
Z=rb+j*w*Lb;
for n=1:N+1
   ABCD_base(:,:,n)=[1,Z(n);0,1];
end;

%find ABCD parameters of the collector lead
ABCD_collector=zeros(2,2,N+1);
Z=rc+j*w*Lc;
for n=1:N+1
   ABCD_collector(:,:,n)=[1,Z(n);0,1];
end;

% compute ABCD parameters of the transistor die with 
% base and collector leads attached

ABCD_bc=zeros(2,2,N+1);
for(n=1:N+1)
   ABCD_bc(:,:,n)=ABCD_base(:,:,n)*ABCD_die(:,:,n)*ABCD_collector(:,:,n);
end;

%find S-parameters of the transistor with base and collector leads
S_bc=ABCD_to_S(ABCD_bc,Z0);
s_param=S_bc;
dim=size(s_param);
s11=zeros([1 dim(3)]);
s21=zeros([1 dim(3)]);
s11(:)=s_param(1,1,:);
s21(:)=s_param(2,1,:);

% plot S11
figure(m_s11);
plot(real(s11),imag(s11),'b','linewidth',2);

% plot S21
figure(p_s21);
polar(angle(s21),abs(s21),'b');

% find corresponding Z-parameters
Z_bc=ABCD_to_Z(ABCD_bc);
z_param=Z_bc;
dim=size(z_param);
z11=zeros([1 dim(3)]);
z22=zeros([1 dim(3)]);
z11(:)=z_param(1,1,:);
z22(:)=z_param(2,2,:);

% plot input impedance Z11
figure(m_z11);
semilogx(f, abs(z11),'b','linewidth',2);

% plot output impedance Z22
figure(m_z22);
semilogx(f, abs(z22),'b','linewidth',2);

%************************************************
% finally emitter lead is attached to the rest
% of the transistor
%

% find Z parameters of the emitter lead
Z_emitter=zeros(2,2,N+1);
Z=re+j*w*Le;
for n=1:N+1
   Z_emitter(:,:,n)=[Z(n),Z(n);Z(n),Z(n)];
end;

% compute Z-parameters for the entire transistor
Z_tr=zeros(2,2,N+1);
for(n=1:N+1)
   Z_tr(:,:,n)=Z_bc(:,:,n)+Z_emitter(:,:,n);
end;

%find the S-parameters of the entire transistor
S_tr=Z_to_S(Z_tr,Z0);
s_param=S_tr;
dim=size(s_param);
s11=zeros([1 dim(3)]);
s21=zeros([1 dim(3)]);
s11(:)=s_param(1,1,:);
s21(:)=s_param(2,1,:);

% plot S11 in the Smith Chart
figure(m_s11);
plot(real(s11),imag(s11),'g','linewidth',2);
title('\bfInput reflection coefficient S_{11}');
%print -deps 'fig7_22a.eps'

% plot S21 in polar plot form
figure(p_s21);
polar(angle(s21),abs(s21),'g');
title('\bfForward transistor gain S_{21}');
%print -deps 'fig7_22b.eps'

% compute corresponding Z-parameters
z_param=Z_tr;
dim=size(z_param);
z11=zeros([1 dim(3)]);
z22=zeros([1 dim(3)]);
z11(:)=z_param(1,1,:);
z22(:)=z_param(2,2,:);

% plot input impedance
figure(m_z11);
semilogx(f, abs(z11),'g','linewidth',2);
axis([1e6 1e11 0 600]);
title('\bfInput impedance');
xlabel('Frequency {\itf}, Hz');
ylabel('Input impedance |Z_{11}|, \Omega');
legend('transistor die', 'with base and collector', 'complete transistor',1);
%print -deps 'fig7_21a.eps'

% plot output impedance
figure(m_z22);
semilogx(f, abs(z22),'g','linewidth',2);
title('\bfOutput impedance');
xlabel('Frequency {\itf}, Hz');
ylabel('Output impedance |Z_{22}|, \Omega');
legend('transistor die', 'with base and collector', 'complete transistor',1);
%print -deps 'fig7_21d.eps'
