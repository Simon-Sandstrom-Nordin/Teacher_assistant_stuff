clc; clear all; close all;
T = [-15, -10, -5, 0];
P = [1.24, 1.95, 3.01, 4.58];
figure(1);
plot(T,P, 'ko'); title("quadratic interpolation")
hold on;
lin = @(x) P(2) + (P(3) - P(2))/(T(3) - T(2)) * (x-T(2));
x = linspace(-11, -4);
%plot(x, lin(x), 'k')
%disp("linear at -8: " +lin(-8))
hold on;
%plot(-8, lin(-8), 'ro')

t_v = [T(2), T(3), T(4)]';
p_v = [P(2), P(3), P(4)]';

A = [1, t_v(1)-t_v(2), (t_v(1)-t_v(2))^2;
    1, t_v(2)-t_v(2), (t_v(2)-t_v(2))^2;
    1, t_v(3)-t_v(2), (t_v(3)-t_v(2))^2];
c = A \ p_v;
quad = @(x) c(1) + c(2)*(x - t_v(2)) + c(3)*(x - t_v(2)).^2;
hold on;
plot(x, quad(x), 'k')
hold on;
plot(-8, quad(-8), 'ro')
disp("quad_1 at -8: " + quad(-8))

t_v = [T(1), T(2), T(3)]';
p_v = [P(1), P(2), P(3)]';

A = [1, t_v(1)-t_v(2), (t_v(1)-t_v(2))^2;
    1, t_v(2)-t_v(2), (t_v(2)-t_v(2))^2;
    1, t_v(3)-t_v(2), (t_v(3)-t_v(2))^2];
c = A \ p_v;
quad = @(x) c(1) + c(2)*(x - t_v(2)) + c(3)*(x - t_v(2)).^2;
hold on;
plot(x, quad(x), 'b')
hold on;
plot(-8, quad(-8), 'ro')
disp("quad_2 at -8: " + quad(-8))
