clc; clear; close all;
rng(001208), C = randi(100,3,4)

% cost vector
c = [C(1,:), C(2,:), C(3,:)]';
b = [33, 31, 43, -27, -29, -17]';

% incidence matrix
A = [1  1  1  1  0  0  0  0  0  0  0  0;
     0  0  0  0  1  1  1  1  0  0  0  0;
     0  0  0  0  0  0  0  0  1  1  1  1;
     -1 0  0  0  -1 0  0  0  -1 0  0  0;
     0  -1 0  0  0  -1 0  0  0  -1 0  0
     0  0  -1 0  0  0  -1 0  0  0  -1 0];

% basic feasable solution
x = [27 6 0 0 0 23 8 0 0 0 9 34]';
c'*x

disp("Initial value of objective function: " + num2str(c' * x))

T = [1, 2, 6, 7, 11, 12];   % initial basis

% Basic incidence matrix
A_b = [A(:,T(1)),A(:,T(2)),A(:,T(3)),A(:,T(4)),A(:,T(5)),A(:,T(6))]
c_b = [c(T(1)), c(T(2)), c(T(3)), c(T(4)), c(T(5)), c(T(6))];

% y = [u1, u2, u3, v1, v2, v3, v4]
% determine "simplex multipliers"
%v4 = 0; % zero by definition
%u3 = v4 + C(3,4)
%v1 = u3 - C(3,1)
%u2 = v1 + C(2,1)
%v2 = u2 - C(2,2)
%u1 = v2 + C(1,2)
%v3 = u1 - C(1,3)

% c_b
u_v = c_b * inv(A_b);
u = u_v(1:3);
v = u_v(4:end);
v = [v, 0]; % v4 = 0 by def.

R = zeros(3,4);
for i = 1:3
    for j = 1:4
        R(i,j) = C(i,j) - u(i) +v(j);
    end
end
R

% update basis
T = [1, 4, 6, 7, 11, 12];   % initial basis

% Basic incidence matrix
A_b = [A(:,T(1)),A(:,T(2)),A(:,T(3)),A(:,T(4)),A(:,T(5)),A(:,T(6))]
c_b = [c(T(1)), c(T(2)), c(T(3)), c(T(4)), c(T(5)), c(T(6))];

x = [27 0 0 6 0 29 2 0 0 0 15 28]';

A*x
c'*x



% simplex things

% un-update basis
T = [1, 2, 6, 7, 11, 12]; 
A_b = [A(:,T(1)),A(:,T(2)),A(:,T(3)),A(:,T(4)),A(:,T(5)),A(:,T(6))]
c_b = [c(T(1)), c(T(2)), c(T(3)), c(T(4)), c(T(5)), c(T(6))];

disp("Tinkering...")
%x = [27 6 0 0 0 23 8 0 0 0 9 34]'
%A
%A*x
%b
%b_bar = inv(A_b) * b
b_bar = [27 6 23 8 9 34];
y = inv(A_b') * c_b'

N = [3, 4, 5, 8, 9, 10];
A_n = [A(:,N(1)),A(:,N(2)),A(:,N(3)),A(:,N(4)),A(:,N(5)),A(:,N(6))]
c_n = [c(N(1)), c(N(2)), c(N(3)), c(N(4)), c(N(5)), c(N(6))]';

r_n = c_n - A_n' * y

a_n_2 = inv(A_b) * A_n(:,2)
% A_n
% A_n(:,2)
% inv(A_b)

% update basis
T = [1, 4, 6, 7, 11, 12]; 
A_b = [A(:,T(1)),A(:,T(2)),A(:,T(3)),A(:,T(4)),A(:,T(5)),A(:,T(6))];
c_b = [c(T(1)), c(T(2)), c(T(3)), c(T(4)), c(T(5)), c(T(6))];

b_bar = inv(A_b) * b
y = inv(A_b') * c_b'

N = [3, 2, 5, 8, 9, 10];
A_n = [A(:,N(1)),A(:,N(2)),A(:,N(3)),A(:,N(4)),A(:,N(5)),A(:,N(6))];
c_n = [c(N(1)), c(N(2)), c(N(3)), c(N(4)), c(N(5)), c(N(6))]';

r_n = c_n - A_n' * y