clc; clear all; close all;

x = [30, 40, 10, 20, 50]; y = [50, 20, 30, 10, 40];
z = [-81.3, -63.5, -57.0, -44.8, -80.7];
A = [ones(5,1), x', y'];
c = A \ z'
plot3(x,y,z, 'ro')
plane = @(x,y) c(1) + c(2) .* x + c(3) .* y;
hold on; plot3(x,y, plane(x,y), 'bo');
plane(10, 10)