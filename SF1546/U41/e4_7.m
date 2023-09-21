clc; clear all; close all;

T = [20.0, 25.5, 30.2, 36.8, 41.0];
L = [8.78, 8.93, 9.06, 9.25, 9.40];

A = [ones(5,1), T'];
A'*A
c_3 = round((A'*A), 3, 'significant') \ round(A'*L', 3, 'significant')
c_2 = round((A'*A), 2, 'significant') \ round(A'*L', 2, 'significant')
c = A \ L'

A = [ones(5,1), T' - mean(T)];
c_3 = round((A'*A), 3, 'significant') \ round(A'*L', 3, 'significant')
c_2 = round((A'*A), 2, 'significant') \ round(A'*L', 2, 'significant')
c = A \ L'

% lamda = c(2)/c(1)
% lamda*c(1)
% c(2)

v = [2, 5, 8, 11, 14]; Th = [0, -7.5, -12, -14.5, -16.5];
% parameters
T = 0;
A = [ones(5,1), v'.*ones(5,1), sqrt(v').*ones(5,1)].*(T-33);
c = A \ (Th' - 33);

Siples = @(x, Temp) 33 - (c(1) + c(2) .* x + c(3) .* sqrt(x)).*(33-Temp);
xlin = linspace(2, 14);
figure(3); plot(v, Th, 'ro'); hold on; plot(xlin, Siples(xlin, 0), 'b-')
Siples(7, -5)