clc; clear all; close all;

x = [1, 3, 4, 5]; y = [3, 3, 0, 11];
f1 = y;
f12 = (y(2) - y(1)) / (x(2) - x(1)); f23 = (y(3) - y(2)) / (x(3) - x(2)); f34 = (y(4) - y(3)) / (x(4) - x(3));
f123 = (f23 - f12) / (x(3) - x(1)); f234 = (f34 - f23) / (x(4) - x(2));
f1234 = (f234 - f123) / (x(4) - x(1));

P = @(x) y(1) + f12.*(x-x(1)) + f123.*(x-x(1)).*(x-x(2)) + f1234.*(x-x(1)).*(x-x(2)).*(x-x(3));
x_lin = linspace(1,5); 
f1234
plot(x,y, 'ro'); hold on; plot(x_lin, P(x_lin), 'b-');
hold on; P_l = @(x) y(1) + f12.*(x-x(1)); hold on; plot(x_lin, P_l(x_lin), 'b-');
hold on; P_q = @(x) y(1) + f12.*(x-x(1)) + f123.*(x-x(1)).*(x-x(2)); hold on; plot(x_lin, P_q(x_lin), 'g-');
% Shouldn't diverge at x(2) = 3

x = [1, 3, 4, 5, 7]; y = [3, 3, 0, 11, 6];
f1 = y;
f12 = (y(2) - y(1)) / (x(2) - x(1)); f23 = (y(3) - y(2)) / (x(3) - x(2)); f34 = (y(4) - y(3)) / (x(4) - x(3)); f45 = (y(5) - y(4)) / (x(5) - x(4));
f123 = (f23 - f12) / (x(3) - x(1)); f234 = (f34 - f23) / (x(4) - x(2)); f345 = (f45 - f34) / (x(5) - x(4));
f1234 = (f234 - f123) / (x(4) - x(1)); f2345 = (f345 - f234) / (x(5) - x(2));
f12345 = (f2345 - f1234) / (x(5) - x(1));
P = @(x) y(1) + f12.*(x-x(1)) + f123.*(x-x(1)).*(x-x(2)) + f1234.*(x-x(1)).*(x-x(2)).*(x-x(3)) + f12345.*(x-x(1)).*(x-x(2)).*(x-x(3)).*(x-x(4));
x_lin = 1:1:7;
figure(2)
plot(x,y, 'ro'); hold on; plot(x_lin, P(x_lin), 'b-');
f12345