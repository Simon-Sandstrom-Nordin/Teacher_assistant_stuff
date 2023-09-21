clc; clear all; close all;

Day = [151, 166, 181];
Length = [20*60 + 56, 22*60 + 24, 22*60 + 1];

figure(1)
plot(Day, Length, 'ro')

A = [1, Day(1)-Day(2), (Day(1)-Day(2))^2;
    1, Day(2)-Day(2), (Day(2)-Day(2))^2;
    1, Day(3)-Day(2), (Day(3)-Day(2))^2];
c = A \ Length';
x = linspace(Day(1), Day(end));
quad = @(x) c(1) + c(2)*(x - Day(2)) + c(3)*(x - Day(2)).^2;
hold on;
plot(x, quad(x), 'b')

A = [1, Day(1)-Day(1), (Day(1)-Day(1))^2;
    1, Day(2)-Day(1), (Day(2)-Day(1))^2;
    1, Day(3)-Day(1), (Day(3)-Day(1))^2];
c = A \ Length';
x = linspace(Day(1), Day(end));
quad = @(x) c(1) + c(2)*(x - Day(1)) + c(3)*(x - Day(1)).^2;
hold on;
plot(x, quad(x), 'k')
quad_prime = @(x) c(2) + 2*c(3)*(x - Day(1));
longest_day = -c(2) / (2*c(3)) + Day(1)
length_max = quad(longest_day)

A = [1, Day(1)-Day(3), (Day(1)-Day(3))^2;
    1, Day(2)-Day(3), (Day(2)-Day(3))^2;
    1, Day(3)-Day(3), (Day(3)-Day(3))^2];
c = A \ Length';
x = linspace(Day(1), Day(end));
quad = @(x) c(1) + c(2)*(x - Day(3)) + c(3)*(x - Day(3)).^2;
hold on;
plot(x, quad(x), 'r')

quad_prime = @(x) c(2) + 2*c(3)*(x - Day(3));
longest_day = -c(2) / (2*c(3)) + Day(3)
length_max = quad(longest_day)

% figure 2
disp('test')
A = [1, Day(1)-Day(3), (Day(1)-Day(3))^2;
    1, Day(2)-Day(3), (Day(2)-Day(3))^2;
    1, Day(3)-Day(3), (Day(3)-Day(3))^2];
c = A \ Length';
x = linspace(Day(1), Day(end));
quad = @(x) c(1) + c(2)*(x - Day(3)) + c(3)*(x - Day(3)).^2;
hold on;
plot(x, quad(x), 'r')

quad_prime = @(x) c(2) + 2*c(3)*(x - Day(3));
longest_day = -c(2) / (2*c(3)) + Day(3)
length_max = quad(longest_day)

A = [1, Day(1), Day(1)^2;
    1, Day(2), Day(2)^2;
    1, Day(3), Day(3)^2];
c = A \ Length';
x = linspace(Day(1), Day(end));
quad = @(x) c(1) + c(2).*x + c(3).*x.^2;
hold on;
plot(x, quad(x), 'r')

quad_prime = @(x) c(2) + 2*c(3)*x;
longest_day = -c(2) / (2*c(3))