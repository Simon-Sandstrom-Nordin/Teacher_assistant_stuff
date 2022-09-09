% Icke-linj(är) skal(är) ekvation med Newtons metod
clc; clear all; close all; format long;

% For finding the constants of convergence, we've seen that the relative
% errors are not that good for this. We'll need the true error, and for
% that we're looking to the future and procure the real roots:
low_root = 0.000000000003810;  high_root = 3.928727810646067;


% bestäm rötter till
f = @(x) 62.*x - ((x.^2 + x + 0.04) ./ (2.*x + 1)).^7 - 19.*x.*exp(-x);
% note: när det inte funkar att dra en vektor genom funktionen, kolla så
% att alla operatorer för multiplikation, division, och exponentiering
% har en punkt innan för att göra operationerna elementvisa. Jag missade
% punkten vid "./".

% den här kommer behövas senare: ... kanske.
fp = @(x) 14 .* (x.^2 + x + .04).^7 ./ (2.*x + 1).^8 - ...
    7 .* (x.^2 + x + .04).^6 ./ (2.*x + 1).^6 + 19.*exp(-x).*(x -1) + 62;

%fp = @(x) 62 - 7.*((x.^2 + x + .04) ./ (2.*x + 1)) ...
%    .*((2*x.^2 + 2*x + .92)./(4*x.^2 + 4.*x + 1)) ...
%    + 19 .* exp(-x) .* (x - 1);
% The middle part was hard to differentiate, and I got
% 7*((x.^2 + x + .04) ./ (2*x + 1)).*((2*x.^2 + 2*x + .92)./(4*x.^2 + 4.*x + 1))
% which I thought was cor

% a. Grovlokalisera den största och den minsta roten. Genom följande prov
% ses att f(0)*f(1) < 0 & f(1)*f(4) < 0, alltså finns det rötter i de två
% intervallen. Av lydelsen antas att det bara finns två positiva rötter.
% Detta är dock inte uppenbart, och svårt att urskilja från funktionens
% utseende, annat än att den blir... nej, det är svårt.

f([0 1 4]')
%f(0)
%f(1)
%f(2)

x = linspace(-2, 10);
plot(x, f(x), 'o'); ylim([-150, 150]); title("both roots");

figure(12)
plot(linspace(0,.0000001, 100), f(linspace(0,.0000001, 100)));
title("lowest root");

figure(3)
plot(linspace(3.92, 3.94, 100), f(linspace(3.92, 3.94, 100)));
title("highest root");

% Part c: determine roots with Newton's method
tol = 10^(-8);  % this is for "relativfel", relative error in Sauer.
                % relative error = abs(x_c - x) / abs(x)

% I'll postphone this slightly... wouldn't I have to know the
% root to calculate the relative error?
% ok, Sauer 1.2.4 Stopping criteria. The relative error 
% stopping critera is (abs(x_iplus1 - x_i) / abs(x_i_plus_1)) < TOL

% What's a constant of convergence?
% answer: error_next = M * error_previous ^ alpha, where
% M is the constant of convergence and 
% alhpa is the order of convergence. 2 for Newtons.
% M = error_nect / (error_previous^alpha)
% to get alpha, take a second point: error_previous =
% M*error_previouser^alpha and combine the two equations, use log-laws,
% and solve for alpha.

% lowest root
x0 = 1; list_1 = [x0]; error_list_1 = []; true_error_list_1 = [];
max_iter = 100; iter = 1; error = 1;
while (iter < max_iter) && (error > tol)
    x1 = x0 - f(x0)/ fp(x0);
    error = abs(x1 - x0) / abs(x1);
    if iter ~= 1        % I don't want to include my error = 1
        error_list_1(end+1) = error;
    end
    x0 = x1; list_1(end+1) = x1;
    iter = iter + 1;
    true_error = abs(x1 - low_root);
    true_error_list_1(end + 1) = true_error;
end
disp("low root is: " + x1);
disp("List of first iterations: "); disp(list_1');
disp("Relative error list one is: ")
disp(error_list_1')
disp("True error list one is: ")
disp(true_error_list_1')

% Finding contant of convergence
M_1_list = []; order = 2;
for k = 1: length(true_error_list_1) - 1 - 2    % minus två för lärdomen.
    M_1 = true_error_list_1(k+1) / (true_error_list_1(k).^order);
    M_1_list(end + 1) = M_1;
end
disp("Constants of convergence for low root: ");disp(M_1_list');


% highest root
x0 = 3.5; list_2 = [x0]; error_list_2 = []; true_error_list_2 = [];
max_iter = 100; iter = 1; error = 1;
while (iter < max_iter) && (error > tol)
    x1 = x0 - f(x0)/ fp(x0);
    error = abs(x1 - x0) / abs(x1);
    if iter ~= 1        % I don't want to include my error = 1
        error_list_2(end+1) = error;
    end
    x0 = x1; list_2(end+1) = x1;
    iter = iter + 1;
    true_error = abs(x1 - high_root);
    true_error_list_2(end + 1) = true_error;
end
disp("high root is: " + x1);
disp("List of second iterations: " );disp(list_2') 
disp("Relative error list two is: ")
disp(error_list_1')
disp("True error list two is: ")
disp(true_error_list_2')

% Finding contant of convergence
M_2_list = []; order = 2;
for k = 1: length(true_error_list_2) - 1 - 2    % minus två för lärdomen.
    M_2 = true_error_list_2(k+1) / (true_error_list_2(k).^order);
    M_2_list(end + 1) = M_2;
end
disp("Constants of convergence for high root: ");disp(M_2_list');

% ... it keeps bouncing back to the low root. edit: I fixed it! fp wrong.

% lärdom: ehm, sista felen blir jättesmå så datorns maskinosäkerhet tar
% plats.
