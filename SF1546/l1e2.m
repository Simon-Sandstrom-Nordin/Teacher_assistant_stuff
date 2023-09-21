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

fp = @(x) 21*(x.^2 + x + .04).^7 / ( 3*x + 1).^8 ...
    - 7 * (2.*x + 1).*(x.^2 + x + .04).^6 / (3.*x + 1).^7 ...
    - 19.*exp(-x) + 19.*exp(-x).*x + 62

% low root
tol = 1e-8; error = 1; maxiter = 10^6; iter = 1;
x = 0; x_list = [x]; error_list = [];
while error > tol && iter < maxiter
    x_new = x - f(x) / fp(x);
    error = abs((x_new - x) / x_new);
    x = x_new;
    iter = iter + 1;
    x_list(end+1) = x_new;
    error_list(end+1) = error;
    if iter == maxiter
        disp("max iter hit")
    end
end
error_list'
x_list'
x
% U41, anmäl extratimme, 25 Jan 15-17.

,
% high root
error = 1; iter = 1;
x = 7; x_list = [x]; error_list = [];
while error > tol && iter < maxiter
    x_new = x - f(x) / fp(x);
    error = abs((x_new - x) / x_new);
    x = x_new;
    iter = iter + 1;
    x_list(end+1) = x_new;
    error_list(end+1) = error;
    if iter == maxiter
        disp("max iter hit")
    end
end
error_list'
x_list'
x

% finding constant of convergence for high root
M_list = [];
for k = 1:length(error_list)-1
    M_list(end+1) = error_list(k+1) / error_list(k)^2;
end
M_list'