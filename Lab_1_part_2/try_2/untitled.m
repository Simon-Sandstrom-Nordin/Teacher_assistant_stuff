% testing Euler
clc; clear all; close all;
yp = @(x,y) x.*y;
y0 = 1;
x0 = 2;

x_list = [x0];
y_list = [y0];
h = .1;
n = 5;

for k = 1:n
    y_list(end + 1) = testEuler(yp, x_list(end), y_list(end), h);
    x_list(end + 1) = x_list(end) + h;
end
plot(x_list, y_list, '-or')

% we have an analytical solution here.
an = @(x) exp(-2)*exp((x.^2) ./ 2);
hold on;
plot(x_list, an(x_list), '-ob')

% ode45
hold on;
ode45(yp, [x0, x0+n*h], y0)

function y_next = testEuler(fun, x, y, h)
    y_next = y + h.*fun(x, y);
end

