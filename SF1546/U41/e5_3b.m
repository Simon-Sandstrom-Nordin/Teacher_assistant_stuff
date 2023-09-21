clc; clear all; close all;

x = [1, 3, 4, 5]; y = [3, 3, 0, 11];
A = [1, (x(1)-x(1)), (x(1)-x(1))*(x(1)-x(2)), (x(1)-x(1)).*(x(1)-x(2))*(x(1)-x(3));
    1, (x(2)-x(1)), (x(2)-x(1))*(x(2)-x(2)), (x(2)-x(1)).*(x(2)-x(2))*(x(2)-x(3));
    1, (x(3)-x(1)), (x(3)-x(1))*(x(3)-x(2)), (x(3)-x(1)).*(x(3)-x(2))*(x(3)-x(3));
    1, (x(4)-x(1)), (x(4)-x(1)).*(x(4)-x(2)), (x(4)-x(1)).*(x(4)-x(2))*(x(4)-x(3))];

c = A \ y'
P = @(x) c(1) + c(2).*(x-x(1)) + c(3).*(x-x(1)).*(x-x(2)) + c(4).*(x-x(1)).*(x-x(2)).*(x-x(3));
hold on; plot(x,y, 'ro')
x_lin = linspace(x(1), x(end)); plot(x_lin, P(x_lin), 'b-')