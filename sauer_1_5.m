% Sauer 1.5 excercises
clc; clear all; close all; format long;

% correct root
x_correct = 1.769292354238631;
error_list_newton = []; error_list_secant = [];

% 1. two steps of secant method
x0 = 1; x1 = 2;

% a)
f = @(x) - x.^3 + 2.*x + 2;
secant = @(x, x_old) (f(x) - f(x_old)) / (x - x_old);

list_sescant = [x0, x1];
iter = 1;
while iter <= 8
    x_new = x1 - f(x1) / secant(x1, x0);
    x0 = x1;
    x1 = x_new;
    list_sescant(end + 1) = x_new;
    iter = iter + 1;
    error_list_secant(end + 1) = abs(x_correct-x_new);
end
disp("Secant method")
disp(list_sescant')
disp("Secant error list")
disp(error_list_secant')

% contants of convergence?
for k = 2:length(error_list_secant)
    disp(error_list_secant(k) / error_list_secant(k-1)^1.62)
end
% http://www1.maths.leeds.ac.uk/~kersale/2600/Notes/appendix_D.pdf
% says order of convergence of secant method is roughly 1.62

x_vector = -2:.1:2;
plot(x_vector, f(x_vector), 'o')
% Indeed, we've found the one and only root!
fp = @(x) - 3.*x.^2 + 2;

% one point four something, newton
iter = 1; % 1. two (or more) steps of secant method
x0 = 1; x1 = 2; list_newton = [x0, x1];

while iter <= 8
    x_new = x1 - f(x1) / fp(x1);
    list_newton(end + 1) = x_new;
    x1 = x_new;
    iter = iter + 1;
    error_list_newton(end + 1) = abs(x_correct-x_new);
end
disp("Newton's method")
disp(list_newton')
disp("Newton error list")
disp(error_list_newton')

% contants of convergence?
for k = 2:length(error_list_newton)
    disp(error_list_newton(k) / error_list_newton(k-1)^2)
end
