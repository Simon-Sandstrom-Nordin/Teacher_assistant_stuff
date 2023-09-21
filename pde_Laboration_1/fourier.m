clc; clear all; close all;

% b_n = (1/(pi*n^3)) * (4 - 2*pi*n*sin(n*pi) - 4*n*cos(pi*n))
N = 10;


f = @(x, t) 0;
for n = 1:N
    term = @(x, t) (1/(pi*n^3)) * (4 - 2*pi*n*sin(n*pi) - 4*n*cos(pi*n)) ...
        .* sin(n*x) .* exp(-t*n^2);
    f = @(x,t) f(x,t) + term(x,t);
end


