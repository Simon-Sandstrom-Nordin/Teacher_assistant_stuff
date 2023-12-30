PersonalNumber = 970829; %YYMMDD

var u; %voltage
var theta_L; %robot arm angle
var theta_m; %motor axle angle
var I_a; %motor current
var T; %torque

L_m = 2; %induction
R_m = 21; %resistance
b = 1; %friction coefficient
[J,umax] = lab3robot(PersonalNumber); %moment of inertia, max value of control signal
K_tao = 38; %material constant
K_m = 0.5; %material constant
n = 1/20; %gearing factor

s = tf( 's' );

G1 = 1/(s*L_m + R_m);
G2 = K_tao;
G3 = 1/(J*s + b);
H1 = -K_m;
G4 = 1/s;
G5 = n;
GA = G1 * G2 * G3; %combine G1, G2 and G3
GB = G4 * G5; %combine G4 and G5

G = GB * feedback( GA, H1, +1 ); %combine all parts of figure 2 into G(s)

lab3robot(G,PersonalNumber) %check G(s)

Kp = 8.07; %K for p-controller, Kp=8.07 for assignment 2
Fp = Kp; %p-controller
v = 0; %v=0 for assignment 2

Gc_p = feedback( Fp * G , 1 ); %closed loop system according to figure 3

Go_p = Fp * G ; %open loop system according to fig 3

figure(1) %step response of closed loop system for assignment 2.
step( Gc_p ); grid



figure(2) %bode diagram of open loop system for assignment 3.
bode( Go_p )

figure(3) %bode diagram of closed loop system for assignment 3.
bode( Gc_p )



figure(4) %bode diagram without controller to compare with figure 3.
bode( G )

figure(5) %bode diagram of unstable closed loop system for assignment 4.
K_unstable = 436/1.9;
Gc_unstable = feedback( K_unstable * G , 1 ); %unstable closed loop system
bode( Gc_unstable )

K = 23; 
tao_D = 1.91; 
beta = 0.14;
tao_I = 8.1; 
gamma = 0.054; 
%commented values also work but have poorer performance
% K = 25; 
% tao_D = 1.73;
% beta = 0.17;
% tao_I = 14;
% gamma = 0.059;

F_lead = K * (tao_D * s + 1)/(beta * tao_D * s + 1);
F_lag = (tao_I * s + 1)/(tao_I * s + gamma);
F_leadlag = F_lead * F_lag;

Go_leadlag = G * F_leadlag; %open loop system with lead-lag compensator
Gc_leadlag = feedback( F_leadlag * G , 1 ); %closed loop system with lead-lag compensator

figure(6) %bode diagram of open loop system with lead-lag compensator
bode( Go_leadlag )

figure(7) %step response of closed loop system with lead-lag compensator
step( Gc_leadlag ); grid

figure(8) %u(t) for step response r(t) with lead-lag compensator
step( Gc_leadlag/G ); grid

S_leadlag = 1 / ( 1 + F_leadlag * G ); %transfer function from reference to error 
%also sensitivity function with lead-lag
t = ( 0 : 0.1 : 100 ).';
r = t; %ramp input
y = lsim( S_leadlag, r, t );
figure(9) %error at time t when r is a ramp input
plot( t, y )

S_proportional = 1 / (1 + Go_p); %sensitivity function with proportional controller

figure(10) %bode diagram of both sensitivity functions for assignment 8.
bodemag(S_proportional, S_leadlag);

deltaG1 = (s+10)/40; %proposal 1 of model error
deltaG2 = (s+10)/(4*(s+0.01)); %proposal 2 of model error

T_leadlag = 1 - S_leadlag;

figure(11) %bode diagram of deltaG1 and 1/T
bodemag(deltaG1, 1/T_leadlag)

figure(12) %bode diagram of deltaG2 and 1/T
bodemag(deltaG2, 1/T_leadlag)

A = [0 n 0 ; 0 -b/J K_tao/J ; 0 -K_m/L_m -R_m/L_m];
B = [0; 0; 1/L_m];
C = [1 0 0];

SYS = ss(A,B,C,[]); %state space
L = place(A, B, [-3, -3+3i, -3-3i]); %place poles
Gc0 = ss( SYS.a - SYS.b * L, SYS.b, SYS.c, 0 ); %closed system with u=-Lx+r feedback
L0 = 1 / dcgain( Gc0 ); %set L0 so that dc gain = 1
Gc = Gc0 * L0;

%true transfer functions since robot arm is not stiff with relative model errors 1 and 2
Gtrue1 = G*(1+deltaG1); 
Gtrue2 = G*(1+deltaG2);
%lab3robot(G,Fp,F_leadlag,A,B,C,L,L0,PersonalNumber) %test