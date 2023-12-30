clc; clear; close all;

% Usage:
% [J,umax]=lab3robot(PersonalNumber) generates the constants J and umax.
% OR
% lab3robot(G,PersonalNumber) (where G is the system transfer function). This validates G.
% OR
% lab3robot(G,K,F,A,B,C,L,L0,PersonalNumber) which opens the GUI and plots the arms for
% the differenct controllers.
% Observe: PersonalNumber should always have the format YYMMDD and be a valid date.

PersonalNumber = 201208; % it gives an error for 001208

[J, umax] = lab3robot(PersonalNumber)

Lm = 2;
Rm = 21;
b = 1;
Kr = 38;
Km = .5;
n = 1/20;


% task 1
G = tf([n*Kr], [J*Lm, Rm*J + Lm*b, Rm*b + Kr*Km, 0])
lab3robot(G, PersonalNumber)

figure(1)
step(G)
figure(2)
bode(G)


%% task 2: proportional control
% K = 7  % lowest integer where overshoot is strictly less than 5 %
Tr = 5.53 - 1.09  % from 10 to 90 percent
% gain 1.03
K = 7.8; % 230 seems to be limit of instability
K = 300

% Gn_new = K.*Gn
%Gn_new = cellfun(@(x) x*K,Gn,'un',0)

%Gd_new = cellfun(@(x,y)x+y, Gn_new, Gd, 'uni',0)
F = tf([K], [1]);

% Go = tf(Gn_new, Gd_new)
Go = F*G;
Gc = F*G / (1 + F*G);

figure(3)
step(Gc)
figure(4)
bode(Go)

figure(5)
rlocus(G)

%% task 3: Improved control
%
%b = 0.007;
%g = 0.00005;
%k = .1*K;
%w_cd = .08*4;   % .08, not .8. wanted now is .24
%tau_i =200/w_cd;
%tau_d = 1/(w_cd*sqrt(b));
% tau_d = .5;
%
%F = tf([k*(tau_d*tau_i), k* (tau_d+tau_i), k*1], [b*tau_d*tau_i, b*tau_d*g + tau_i, g]);
% Gn_new = F*G
%Gc = F*G / (1 + F*G);
%
%figure(6)
%step(Gc)
%figure(7)
%bode(Gc)
%figure(8)   % for u
%step(F / (1 + F*G))

be = .001;
% w_cd = .188    % .047 * 4
w_cd = .28 % .07 * 4
tau_d = 1/(w_cd*sqrt(be))
K = (1/(10^(-7.8/10))) / (1/sqrt(be)) % abs(G(i*w_cd)) = -12.2

e1 =  (40/1.9) / K
c = e1 / .05
gam = 1/c+.001
ti = 10/w_cd
%ti = .04;
p_i = -atan((1-gam)*ti*w_cd /(gam+ ti^2*w_cd^2)) * 360/(2*pi)
K = tf([K], [1])
F_lead = tf([tau_d, 1], [be *tau_d, 1]);
F_lag = tf([ti, 1], [ti, gam]);
Go = G * F_lead * F_lag * K;
figure(11)
Gc = Go / (1+Go);
step(Gc)
figure(12)
bode(Go)
figure(13)
bode(F_lead)
figure(14)
bode(F_lag)
figure(15)
step(Gc * tf([1], [1,0]))

%% pole placement

l3 = (-15 -b/J - Rm/Lm)*Lm
l1 = -250*(Lm / (Kr*n*J))
l2 = (100 - b/J * (Rm + l3)/Lm - Kr*Km / (J*Lm)) * (Lm * J / Kr)
L0 = 1  % for now, adjust at will

C = [1, 0 0]
B = [0, 0, 1/Lm]'
A = [0, n, 0; 0, -b/J, Kr/J; 0, -Km/Lm, -Rm / Lm]   % not A - BL

%s = tf('s')
%trans = C * inv(s*eye(3,3) - A) * B
state_space = ss(A,B,C,0)
L = place( state_space.a, state_space.b, [-3, -3 - 3*1i, -3 + 3*1i ]);
Gc0 = ss( state_space.a - state_space.b * L, state_space.b, state_space.c, 0 );
l_0 = 1 / dcgain( Gc0 );
Gc = Gc0 * l_0;


% L = [l1, l2, l3]

G = tf([n*Kr], [J*Lm, Rm*J + Lm*b, Rm*b + Kr*Km, 0])

s = tf('s')
K = 7.8;
F = tf([K], [1]);
K = 23; 
tao_D = 1.91; 
beta = 0.14;
tao_I = 8.1; 
gamma = 0.054; 

F_lead = K * (tao_D * s + 1)/(beta * tao_D * s + 1);
F_lag = (tao_I * s + 1)/(tao_I * s + gamma);
F_leadlag = F_lead * F_lag;
K = 8.07; 

% K = 400;
lab3robot(G,K,F_leadlag,state_space.a,state_space.b,state_space.c,L,l_0,PersonalNumber)


syms s Lm Rm b Kr Km n J
C = [1, 0 0]
B = [0, 0, 1/Lm]'
A = [0, n, 0; 0, -b/J, Kr/J; 0, -Km/Lm, -Rm / Lm]   % not A - B
trans = C * inv(s*eye(3,3) - A) * B