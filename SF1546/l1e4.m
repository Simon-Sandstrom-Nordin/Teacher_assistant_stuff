clc; clear all; close all;
f = @(x) 62.*x - ((x.^2 + x + 0.04) ./ (2.*x + 1)).^7 - 19.*x.*exp(-x);

% high root
tol = 1e-4; error = 1; maxiter = 10^6; iter = 1;
x0 = 0; x_list = [x0]; error_list = [];
while error > tol && iter < maxiter
    x_new = (62*x_list(end) - f(x_list(end)))/62;
    error = abs((x_new - x_list(end)) / x_new);
    iter = iter + 1;
    x_list(end+1) = x_new;
    error_list(end+1) = error;
    if iter == maxiter
        disp("max iter hit")
    end
end
error_list'
x_list'

% finding constant of convergence for high root
M_list = [];
for k = 1:length(error_list)-1
    M_list(end+1) = error_list(k+1) / error_list(k)^(1);
end
M_list'
