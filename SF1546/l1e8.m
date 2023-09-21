clc; clear all; close all;

figure(1)
integrand = @(x) 159.*exp(-((23.*x - pi) ./ 0.002).^2);
x = linspace(0, 6, 1e+6);
plot(x, integrand(x))
quad(integrand, 0, 6);

figure(2)
a = .136; b = .137;
x = linspace(a,b);
plot(x, integrand(x))
disp("quad")
q = quad(integrand, 0, a) + quad(integrand, a, b, 1e+4) + quad(integrand, b, 6)
disp("integral")
i = integral(integrand, a, b) + integral(integrand, 0, a) + integral(integrand, b, 6)
