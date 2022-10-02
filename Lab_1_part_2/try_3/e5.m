% Tillförlitlighet
clc; clear all; close all; format long;

% a. konstanten 19 i e_02  ökas med +- 3.1 %. Hur påverkas
% värdena Newtons metod konvergerar mot (våra nu approximativa rötter)?
% copy-paste från e_02.m:
variation = 19*.031;
f = @(x) 62.*x - ((x.^2 + x + 0.04) ./ (2.*x + 1)).^7 - (19 + variation).*x.*exp(-x);
fp = @(x) 14 .* (x.^2 + x + .04).^7 ./ (2.*x + 1).^8 - ...
    7 .* (x.^2 + x + .04).^6 ./ (2.*x + 1).^6 + (19 + variation).*exp(-x).*(x -1) + 62;
low_root = 3.810232560470491e-12;  high_root = 3.928727810646067;
tol = 10^(-8);

% low root.
x0 = 1; list_1 = [x0];
max_iter = 100; iter = 1; error = 1;
while (iter < max_iter) && (error > tol)
    x1 = x0 - f(x0)/ fp(x0);
    error = abs(x1 - x0) / abs(x1);
    x0 = x1; list_1(end+1) = x1;
    iter = iter + 1;
end
disp("low root is: ");
x1
disp("Percentage change is: " + (x1 / low_root - 1)*100 + " %")

% high root.
x0 = 3.5; list_2 = [x0];
max_iter = 100; iter = 1; error = 1;
while (iter < max_iter) && (error > tol)
    x1 = x0 - f(x0)/ fp(x0);
    error = abs(x1 - x0) / abs(x1);
    x0 = x1; list_2(end+1) = x1;
    iter = iter + 1;
end
disp("high root is: ");
x1
disp("Percentage change is: " + (x1 / high_root - 1)*100 + " %")

% Increase 19 by 3.1 %
% low root: 1.3888 %
% high root: -0.0035341 %

% Decrease 19 by 3.1 %
% low root: -1.3513 %
% high root: 0.0035326 %

% b. samma sak men en minskning
