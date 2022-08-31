% Icke-linj(är) skal(är) ekvation med Newtons metod
clc; clear all; close all; format long;

% bestäm rötter till
f = @(x) 62.*x - ((x.^2 + x + 0.04) ./ (2.*x + 1)).^7 - 19.*x.*exp(-x);
% note: när det inte funkar att dra en vektor genom funktionen, kolla så
% att alla operatorer för multiplikation, division, och exponentiering
% har en punkt innan för att göra operationerna elementvisa. Jag missade
% punkten vid "./".

% den här kommer behövas senare: ... kanske.
fp = @(x) 62 - 7*((x.^2 + x + .04) ./ (2*x + 1)) ...
    .*((2*x.^2 + 2*x + .92)./(4*x.^2 + 4.*x + 1)) ...
    - 19 * (exp(-x) - x * exp(-x));

% a. Grovlokalisera den största och den minsta roten. Genom följande prov
% ses att f(0)*f(1) < 0 & f(1)*f(4) < 0, alltså finns det rötter i de två
% intervallen. Av lydelsen antas att det bara finns två positiva rötter.
% Detta är dock inte uppenbart, och svårt att urskilja från funktionens
% utseende, annat än att den blir... nej, det är svårt.

f([0 1 4]')
%f(0)
%f(1)
%f(2)

x = linspace(0, 10);
plot(x, f(x)); ylim([-.1, 10]); title("both roots");

figure(2)
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

% lowest root
x0 = 0;
max_iter = 100; iter = 1; error = 1;
while (iter < max_iter) && (error > tol)
    x1 = x0 - f(x0)/ fp(x0);
    error = abs(x1 - x0) / abs(x1);
    x0 = x1;
end
disp("low root is: " + x1);

% highest root
x0 = 4;
max_iter = 100; iter = 1; error = 1;
while (iter < max_iter) && (error > tol)
    x1 = x0 - f(x0)/ fp(x0);
    error = abs(x1 - x0) / abs(x1);
    x0 = x1;
end
disp("high root is: " + x1);
% ... it keeps bouncing back to the low root.

