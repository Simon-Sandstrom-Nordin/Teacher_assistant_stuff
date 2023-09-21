clc; clear all; close all;

t = [0, 2, 4, 6, 8, 10]; y = [1.0, 1.6, 1.4, .6, .2, .8];
A = [ones(6,1), sin((2/12)*pi.*t'), cos((2/12)*pi.*t')];
c = A \ y';
H = @(x) c(1) + c(2).*sin((2/12)*pi.*x) + c(3).*cos((2/12)*pi.*x);
x_lin = linspace(0, 10);
plot(t, y, 'ro'); hold on; plot(x_lin, H(x_lin), 'g')
