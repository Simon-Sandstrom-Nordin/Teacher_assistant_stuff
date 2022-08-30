% Icke-linj(är) skal(är) ekvation med Newtons metod
clc; clear all; close all;

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

%f([0 1 2]')
%f(0)
%f(1)
%f(2)

x = linspace(-4, 3);
plot(x, f(x)); ylim([-1, 1]);