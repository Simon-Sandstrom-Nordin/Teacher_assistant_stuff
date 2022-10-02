clc; clear; close all; format long;

figure(1)
integrand = @(x) 132.*exp(-((14.*x - pi) ./ 0.004).^2);
x = linspace(0, 6, 1e+6);
plot(x, integrand(x))
quad(integrand, 0, 6)

figure(2)
a = .223; b = .225;
x = linspace(a,b);
plot(x, integrand(x))
disp("quad")
quad(integrand, a, b)
disp("integral")
integral(integrand, a, b)

% Next day stuff: quad has a tolerance option
disp("Next")

disp("bottom")
quad(integrand, 0, .223, 1e-9)
integral(integrand, 0, .223, AbsTol=1e-9)
disp("mid")
quad(integrand, .223, .225, 1e-9)
integral(integrand, .223, .225, AbsTol=1e-9)
disp("top")
quad(integrand, .225, 6, 1e-9)
integral(integrand, .225, 6, AbsTol=1e-9)
