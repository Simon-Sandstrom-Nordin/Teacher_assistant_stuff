disp("TA stuff")
clc; clear; close;

% don't mind this
y = @(t) 1 ./ (10^(-6) - .5.*t.*10^(-6));

t_v = linspace(0, 3);

figure(1)
plot(t_v, y(t_v))
