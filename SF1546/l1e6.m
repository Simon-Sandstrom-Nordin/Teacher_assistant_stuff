clc; clear all; close all; format long;
f = @(x) .98*62.*x - ((x.^2 + x + .04) ./ (3.*x + 1)).^7 - 1.03*19.*x.*exp(-x);

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

% alterations
% normal: 
%   0.381023256037529 * 1.0e-11
%   0.381023256036887 * 1.0e-11
%   6.414684290318265
%   6.414684289741624
% + 3 % on 19
%   0.386141880815646 * 1.0*e-11
%   0.386141880971596 * 1.0*e-11
%   6.414666358524400
%   6.414666357429473
% ratio in %
% high: 99.9997 %
% low: 101.3434 %
% - 3 % on 19
%   0.376038559012341 * 1.0*e-11
%   0.376038558856392 * 1.0*e-11
%   6.414702221248426
%   6.414702221185539
% ratio in %
% high: 100.0003 %
% low: 98.6918 %
% + 2 % on 62
%   0.370343580467819 * 1.0*e-11
%   0.370343580686933 * 1.0*e-11
%   6.438313060526001
%   6.438313059793136
% ratio in %
% high: 100.3684 %
% low: 97.1971 %
% - 2 % on 62
%   0.392337164761687 * 1.0*e-11
%   0.392337164980801 * 1.0*e-11
%   6.390657976936539
%   6.390658002122178
% ratio in %
% high: 99.6254 %
% low: 1.0297 %
% lower 19 raise 62 for max on high root and min on low root
%   0.365632669450273 * 1.0*e-11
%   0.365632671569669 * 1.0*e-11
%   6.438330286373238
%   6.438330285648058
% ratio in %
% high: 100.3686 %
% low: .9596 %
% raise 19 lower 62 for min on high root and max on low root
%   0.397766446197407 * 1.0*e-11
%   0.397766448316804 * 1.0*e-11
%   6.390639295889334
%   6.390639321565112
% ratio in %
% high: .996251574186595 %
% low: 104.3942704322216 %