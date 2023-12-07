clc; clear; close all;

rng(001208), C = randi(100,3,4)

A = [1 1 1 -1 0 0 -1 0 0 -1 0 0;
    -1 0 0 1 1 1 0 -1 0 0 -1 0;
    0 -1 0 0 -1 0 1 1 1 0 0 -1;
    0 0 -1 0 0 -1 0 0 -1 1 1 1]

s = [33 31 43]'

d = [27 29 17 34]'

% y's
y3 = C(3,4)
y2 = C(2,3) + y3
y1 = C(1,2) + y2
y4 = 0

% r's
r1_2 = C(1,2) - y1 + y2
r1_3 = C(1,3) - y1 + y3
r1_4 = C(1,4) - y1 + y4
r2_1 = C(2,1) - y2 + y1
r2_3 = C(2,3) - y2 + y3
r2_4 = C(2,4) - y2 + y4
r3_1 = C(3,1) - y3 + y1
r3_2 = C(3,2) - y3 + y2
r3_4 = C(3,4) - y3 + y4

c = [C(:,1); C(:,2); C(:,3); C(:,4)]


b = [s; 0] - d

x = [27 6 0 0 0 23 8 0 0 0 9 34]'

A*x

% Screw these calculations :(

Simon_A = ...
   [1 1 1 1 0 0 0 0 0 0 0 0;
    0 0 0 0 1 1 1 1 0 0 0 0;
    0 0 0 0 0 0 0 0 1 1 1 1];

disp("A")
Simon_A * x     % sums up supply

Simon_B = ...
   [1 0 0 0 1 0 0 0 1 0 0 0;
    0 1 0 0 0 1 0 0 0 1 0 0;
    0 0 1 0 0 0 1 0 0 0 1 0;
    0 0 0 1 0 0 0 1 0 0 0 1];

disp("B")
Simon_B * x     % sums up demand

% Simon_C = Simon_A - Simon_B;
% Simon_C * x

disp("C")

disp("TP algorithm")
Simon_C = [Simon_A; [0 0 0 0 0 0 0 0 0 0 0 0]] - Simon_B
Simon_C*x

Simon_C(:,11) = [];
Simon_C(:,6) = [];
Simon_C(:,1) = [];
% Simon_C;
% 1_2, 1_3, 1_3, 2_1, 2_3, 2_4, 3_1, 3_2, 3_4
T = [1,5,9];    % initial basis

% c;

% cost to stay - yay or nay? Nay.
c(11) = [];
c(6) = [];
c(1) = [];

% y's. Keep C matrix too - it's easy to read what we're doing
y3 = C(3,4)
y2 = C(2,3) + y3
y1 = C(1,2) + y2
y4 = 0

% r's
r1_2 = C(1,2) - y1 + y2
r1_3 = C(1,3) - y1 + y3
r1_4 = C(1,4) - y1 + y4
r2_1 = C(2,1) - y2 + y1
r2_3 = C(2,3) - y2 + y3
r2_4 = C(2,4) - y2 + y4
r3_1 = C(3,1) - y3 + y1
r3_2 = C(3,2) - y3 + y2
r3_4 = C(3,4) - y3 + y4

size(c)
size(x)

b
