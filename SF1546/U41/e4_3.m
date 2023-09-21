clc; close all; clear all;

figure(1)
t = [0, 1, 3, 4]; y = [1, 8, 11, 20];
A = [ones(4,1), t'];
c = A \ y'
line = @(x) c(1) + c(2).*x;
x_lin = linspace(0, 4);
plot(t, y, 'ro'); hold on; plot(x_lin, line(x_lin), 'k-');
%sum = 0;
%for k = 1:4
%    sum = sum + t(k) - line(t(k));
%end
r = A*c - y'
disp("norm")
norm(r)

figure(2)
t = [0, 1, 3, 4]; y = [1, 8, 11, 20];
A = [ones(4,1)];
c = A \ y'
line = @(x) c + 0.*x;
x_lin = linspace(0, 4);
plot(t, y, 'ro'); hold on; plot(x_lin, line(x_lin), 'k-');
r = A*c - y'
disp("norm")
norm(r)

figure(3)
t = [0, 1, 3, 4]; y = [1, 8, 11, 20];
A = [t'];
c = A \ y'
line = @(x) c.*x;
x_lin = linspace(0, 4);
plot(t, y, 'ro'); hold on; plot(x_lin, line(x_lin), 'k-');
r = A*c - y'
disp("norm")
norm(r)

