% Integral med förbehandling
clc; clear all; close all;

% tolerance for pain (or error)
tol = 1e-9;

% we need the limit value of the integrand do do an upper bound
% approximation, and to have a point to use in the trapezoid rule.
integrand = @(x) (1 - exp(-(x./7).^3))./(3.*x.^3);
figure(1)
x = linspace(0, 1e-4);
plot(x, integrand(x), 'o')
% With L'hopital by hand, the limit value for x = 0 is 1/375.