clc; clear all; close all;

f = @(x) (2/pi) * integral(@(a) ((sin(a*pi) - sin(a*pi/2))/a) .* cos(a.*x), 1, 1000);
x = linspace(-2*pi, 2*pi);
plot(x, f(x), 'o')
