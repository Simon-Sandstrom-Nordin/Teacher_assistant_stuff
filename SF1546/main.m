% Lab 0
clc; clear; close;

% 1
A = [1 1 1 -1;
1 1 1 1;
1 2 4 8;
1 4 16 64];

b = [4; 2; -2; 14];

A\b

% 2

x = [2, 3];
y = [5; 7];

a = x*y
b = y*x
c = x.*y'
d = x'.*y
e = x./y'

% 3
A = [1, 2; 3, 4];
B = A^2
C = A.^2
D = A^(-1)
E = A.^(-1)

% 4
x = 0:0.1:1;
% f(x) = cos(x)
f = cos(x)
f = @(x) cos(x)
f(x)

% 5

% 14
list = [1, 1];
for k = 3:23
    list(end+1) = list(k-2) + list(k-1);
end
list

% 15
while list(end) < 10^6
    list(end+1) = list(end) + list(end-1);
end
list(end)