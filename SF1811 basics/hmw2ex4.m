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
disp("Before iterating: with x = [27 6 0 0 0 23 8 0 0 0 9 34]'")

if A*x == b
    disp("Solution is feasable")
end
disp("Initial value of objective function: " + num2str(c' * x))

disp(" ")   % new line
disp("Iteration 1")

T = [1, 2, 6, 7, 11, 12];   % initial basis

% Basic incidence matrix
A_b = [A(:,T(1)),A(:,T(2)),A(:,T(3)),A(:,T(4)),A(:,T(5)),A(:,T(6))];
c_b = [c(T(1)), c(T(2)), c(T(3)), c(T(4)), c(T(5)), c(T(6))];

% c_b
u_v = c_b / A_b;
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
T = [1, 4, 6, 7, 11, 12];

% Basic incidence matrix
A_b = [A(:,T(1)),A(:,T(2)),A(:,T(3)),A(:,T(4)),A(:,T(5)),A(:,T(6))];
c_b = [c(T(1)), c(T(2)), c(T(3)), c(T(4)), c(T(5)), c(T(6))];

b_bar = A_b \ b;
x = [27 0 0 6 0 29 2 0 0 0 15 28]';

if A*x == b
    disp("Solution is feasable")
end
disp("Value of objective function: " + num2str(c' * x))
X = [x(1:4)'; x(5:8)'; x(9:12)']
u
v
R

disp("Iteration 2")

% c_b
u_v = c_b / A_b;
u = u_v(1:3);
v = u_v(4:end);
v = [v, 0]; % v4 = 0 by def.

R = zeros(3,4);
for i = 1:3
    for j = 1:4
        R(i,j) = C(i,j) - u(i) +v(j);
    end
end
R;   % add x_2_4 to basis

% update basis
T = [1, 4, 6, 8, 11, 12];

% Basic incidence matrix
A_b = [A(:,T(1)),A(:,T(2)),A(:,T(3)),A(:,T(4)),A(:,T(5)),A(:,T(6))];
c_b = [c(T(1)), c(T(2)), c(T(3)), c(T(4)), c(T(5)), c(T(6))];

b_bar = A_b \ b
x = [27 0 0 6 0 29 0 2 0 0 17 26]';

if A*x == b
    disp("Solution is feasable")
end
disp("Value of objective function: " + num2str(c' * x))
X = [x(1:4)'; x(5:8)'; x(9:12)']
u;
v;
R;

% disp("Iteration 3")

% c_b
u_v = c_b / A_b;
u = u_v(1:3)
v = u_v(4:end)
v = [v, 0]; % v4 = 0 by def.

R = zeros(3,4);
for i = 1:3
    for j = 1:4
        R(i,j) = C(i,j) - u(i) +v(j);
    end
end
R   % optimal

format long
d = 1
size(u_v);
inv(A_b)*b - .0327868852.*inv(A_b)*u_v'
inv(A_b)*b + .5.*inv(A_b)*u_v'