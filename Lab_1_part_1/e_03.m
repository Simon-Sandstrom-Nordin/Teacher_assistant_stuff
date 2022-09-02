% same as e_02 but with the secant method.
% note 31/8 -22: while Newton's method in e_02 refuses
% to converge on the high root, maybe I'll have better
% luck with this method. Also, we'll have to define and
% determine the rate of convergence. Numerically.
clc; clear all; close;

% For finding the constants of convergence, we've seen that the relative
% errors are not that good for this. We'll need the true error, and for
% that we're looking to the future and procure the real roots:
low_root = 0.000000000003810;  high_root = 3.928727810646067;

% Still the same function
f = @(x) 62.*x - ((x.^2 + x + 0.04) ./ (2.*x + 1)).^7 - 19.*x.*exp(-x);
% ... but now we lack knowledge of the derivative.
% The secant method approximates the derivative numerically,
% but other than that it's the same as Newton's method although
% the rate of convergence is no longer quadratic but something like
% 1.4 :th order. Still better than linear convergence like
% that of repeatedly bracketing the root, but not as good as the
% Newton-Ralphson method. The advantage here, of course, is that
% no explicit formula for the derivative is required.
% If however we cannot get our guesses to converge at roots at all,
% then bracketing might be our only choice. (With the knowledge
% we currently possess.)

secant_approximation = @(x, x_old) (f(x) - f(x_old)) / (x - x_old);

% here, x_new = x - f(x) / secant_approximation(x, x_old)

% lowest root
x_old = 3; x = 10^(-1); x_list = [x_old x]; true_error_list_1 = [];
max_iter = 100; iter = 1; tol = 10^(-8); error = 1;
while (iter < max_iter) && (error > tol)
    x_new = x - f(x) / secant_approximation(x, x_old);
    
    error = abs(x_new - x);
    x_old = x;
    x = x_new;
    x_list(end+1) = x;
    
    true_error = abs(x - low_root);
    true_error_list_1(end + 1) = true_error;
end
disp("Low : "); disp(x_list');
disp("True error list one is: ")
disp(true_error_list_1')

% Finding contant of convergence
M_1_list = []; order = 2;
for k = 1: length(true_error_list_1) - 1 - 1    % minus ett för lärdomen.
    M_1 = true_error_list_1(k+1) / (true_error_list_1(k).^order);
    M_1_list(end + 1) = M_1;
end
disp("Constants of convergence for low root: ");disp(M_1_list');


% highest root
x_old = 4; x = 3; x_list = [x_old x]; true_error_list_2 = [];
max_iter = 100; iter = 1; tol = 10^(-8); error = 1;
while (iter < max_iter) && (error > tol)
    x_new = x - f(x) / secant_approximation(x, x_old);
    
    error = abs(x_new - x);
    x_old = x;
    x = x_new;
    x_list(end+1) = x;

    true_error = abs(x - high_root);
    true_error_list_2(end + 1) = true_error;
end
disp("High : "); disp(x_list');

disp("True error list two is: ")
disp(true_error_list_2')

% Finding contant of convergence
M_2_list = []; order = 2;
for k = 1: length(true_error_list_1) - 1 - 1    % minus ett för lärdomen.
    M_2 = true_error_list_1(k+1) / (true_error_list_1(k).^order);
    M_2_list(end + 1) = M_2;
end
disp("Constants of convergence for high root: ");disp(M_2_list');

