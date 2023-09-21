clc; clear all; close all; format long;
f = @(x) 62.*x - ((x.^2 + x + .04) ./ (3.*x + 1)).^7 - 19.*x.*exp(-x)
f(0)
f(1)
f(7)

figure(1)
subplot(2,2,[1,2]);
plot(linspace(-.1,7), f(linspace(-.1,7)))
subplot(2,2,3);
plot(linspace(-.0001,.0001), f(linspace(-.0001,.0001)));
subplot(2,2,4);
plot(linspace(6.414,6.416), f(linspace(6.414,6.416)));

% low root
tol = 1e-8; error = 1; maxiter = 10^6; iter = 1;
x0 = 0.1; x1 = 0; x_list = [x0, x1]; error_list = [];
while error > tol && iter < maxiter
    sec = (f(x_list(end)) - f(x_list(end-1))) / (x_list(end) - x_list(end-1));
    x_new = x_list(end) - f(x_list(end)) / sec;
    error = abs((x_new - x_list(end)) / x_list(end));
    iter = iter + 1;
    x_list(end+1) = x_new;
    error_list(end+1) = error;
    if iter == maxiter
        disp("max iter hit")
    end
end
error_list'
x_list'

% high root
error = 1; iter = 1;
x0 = 7; x1 = 6.9; x_list = [x0, x1]; error_list = [];
while error > tol && iter < maxiter
    sec = (f(x_list(end)) - f(x_list(end-1))) / (x_list(end) - x_list(end-1));
    x_new = x_list(end) - f(x_list(end)) / sec;
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
    M_list(end+1) = error_list(k+1) / error_list(k)^((1 + sqrt(5))/2);
end
M_list'
