clc; clear; close all;

% Usage:
% [J,umax]=lab3robot(PersonalNumber) generates the constants J and umax.
% OR
% lab3robot(G,PersonalNumber) (where G is the system transfer function). This validates G.
% OR
% lab3robot(G,K,F,A,B,C,L,L0,PersonalNumber) which opens the GUI and plots the arms for
% the differenct controllers.
% Observe: PersonalNumber should always have the format YYMMDD and be a valid date.

pnr = 201208; % it gives an error for 001208

[J, umax] = lab3robot(pnr)

Lm = 2;
Rm = 21;
b = 1;
Kr = 38;
Km = .5;
n = 1/20;


% task 1
G = tf([n*Kr], [J*Lm, Rm*J + Lm*b, Rm*b + Kr*Km, 0])
lab3robot(G, pnr)

figure(1)
step(G)
figure(2)
bode(G)


%% task 2: proportional control
% K = 7  % lowest integer where overshoot is strictly less than 5 %
Tr = 5.53 - 1.09  % from 10 to 90 percent
% gain 1.03
K = 7.8; % 230 seems to be limit of instability

F = tf([K], [1]);

% Go = tf(Gn_new, Gd_new)
Gc = feedback(G*F, 1);

figure(3)
step(Gc)
figure(4)
bode(Gc)

figure(5)
rlocus(G)

%% task 3: Improved control

b = .7;
w_cd = .188    % .047 * 4
tau_d = 1/(w_cd*sqrt(b))
K = 1/(10^(-12.2/10))  % abs(G(i*w_cd)) = -12.2

e1 =  (40/1.9) / K
c = e1 / .05
gam = 1/c
ti = 10/w_cd
%ti = .04;
p_i = -atan((1-gam)*ti*w_cd /(gam+ ti^2*w_cd^2)) * 360/(2*pi)

F_lead = tf([tau_d, 1], [b *tau_d, 1]);
F_lag = tf([K*ti, K], [ti, gam]);
Go = G * F_lead * F_lag;
figure(11)
Gc = Go / (1+Go);
step(Go)
figure(12)
bode(Go)
