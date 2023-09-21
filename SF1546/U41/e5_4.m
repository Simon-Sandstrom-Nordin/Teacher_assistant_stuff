clc; clear all; close all;

Deg = [55.7, 57.7, 59.3, 62.6, 65.6]';
Len_hour = [17, 18, 18, 19, 22]';
Len_min = [28, 0, 31, 56, 34]';
Len = zeros(1, length(Len_min));
for k = 1:length(Len_min)
    Len(k) = Len_hour(k)*60 + Len_min(k);
end
figure(1)
plot(Deg, Len, 'o')
xq = linspace(55.7, 65.6);
yq = spline(Deg, Len, xq);
hold on;
plot(xq, yq)
disp("Spline: " + spline(Deg, Len, 61.7))

t_v = [Deg(2), Deg(3), Deg(4)]';
p_v = [Len(2), Len(3), Len(4)]';

A = [1, t_v(1)-t_v(2), (t_v(1)-t_v(2))^2;
    1, t_v(2)-t_v(2), (t_v(2)-t_v(2))^2;
    1, t_v(3)-t_v(2), (t_v(3)-t_v(2))^2];
c = A \ p_v;
x = linspace(Deg(1), Deg(end));
quad = @(x) c(1) + c(2)*(x - t_v(2)) + c(3)*(x - t_v(2)).^2;
hold on;
plot(x, quad(x), 'b')
hold on;
plot(61.7, quad(61.7), 'ro')
disp("quad: " + quad(61.7))