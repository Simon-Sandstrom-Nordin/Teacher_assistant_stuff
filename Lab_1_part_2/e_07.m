% Integral med förbehandling
clc; clear all; close all;

% notes:
% tolerance for pain (or error)
tol = 1e-9;
% analytisk förbehandling: fiffla lite innan du utför
% numerisk integration med trapetsmetoden.
% inbyggda funktioner för jämförelse: quad, integral, trapz
% ... eller analytiska värdet.

% a. Plot the integrand.
integrand = @(x) (1 - exp(-(x./7).^3))./(3.*x.^3);
figure(1)
x = linspace(0, 2*10e-4);
plot(x, integrand(x), 'o')
% it looks the way it does, especially without the 'o'
% option, since MATLAB does a linear interpolation. The
% second data point "shoots off"?

% b. Svanskapning?
figure(2)
B = 1000; % Where we'll cut off.
% B = 1000 gives 4 correct digits
% B = 10000 gives more,
% but four seems enough.
% remember, we're trading accuracy for less computing work
% a few extra decimals for ten times the work would be a
% trade-off we're choosing not do do.

x = linspace(0, B);
plot(x, integrand(x), 'o')
% right, the "tail" goes to zero and stays there.
% The question wants me to determine a B such that 
% the contribution from the tail int(B, inf) becomes 
% negligible.
integral(integrand, 0, x(end))

% c. Suggest a way to eliminate the "trembling" effect
% in the beginning.
% ... just pretend it's a straight line?
% or replace the ten first poins with the eleventh or something.
x_2_b = linspace(0, 2*10e-4);
y = integrand(x_2_b);
y_11 = y(11);
for k = 1:10
    y(k) = y_11;
end
figure(3)
plot(x_2_b, y, 'bo')
% oh, the trembling is worse than I thought. How about replacing the
% first points from x = 0 to x = 2 with y(x) = 2)
y_1000 = y(2);
for k = 1:100
    y(k) = y_1000;
end
figure(4)
plot(x_2_b, y, 'ro')

% plot the whole thing

% problem: what is n: the number of points?
n = 1e+5;

x_plot = linspace(0, B, n);
y_plot = integrand(x_plot);
y_1000 = y(2);
for k = 1:100
    y_plot(k) = y_1000;
end
plot(x_plot, y_plot)

% d. We have prepared the integrand early and late. Do
% we need more preparation?
% ... No, this looks good right? It's all smooth.

% e. Now calculate (approximate numerically?) the integral
% with enough certainty, with preperations, and with your
% own written code for the trapezoid rule.

% we're almost ready for this. But what is h?
h = abs(x_plot(1) - x_plot(end)) / length(x_plot)
% problems problems problems... :(

approx_int = e_07_trapz(y_plot, h)
% This takes the value to be NaN)
% ... because the first value of y_plot is NaN...

% f. How would you approximate the error bound numerically
% with your method? Remember to take your preperations
% into consideration.

% error term of the trapezoid method is (p. 256 in Sauer)
% E(h) = h^3 / 12 * max_of_second_derivative_within_interval
% ... however, that's their special case. I think it's
% {absolute} E(h) = length_of_interval * h^2 / 12 * max
% in general, just that their length is h.
% soo... derivate the inegrand twice :((((((((((((.

% Wolfram alpha to the rescue!
% "derivate (1 -
% Divide[exp\(40)Power[\(40)Divide[x,7]\(41),3]\(41),3Power[x,3]]) twice"
% ... it looks god awful.
fpp = @(x) exp(-(x.^3)./343).*(-3.*x.^6 - 1372.*x.^3 + 470596.*exp(x.^3 ./ 343)+ 470596) ./ (117649.*x.^5);
% where's its max so I don't have to see you again
x_crap = linspace(0, B);
figure(6)
plot(x_crap, fpp(x_crap))   % It's still god awful... it goes towards x-ish

% I think matlab uses some maximum constant for the exp(o(x^3)), that's why
% it looks linear after like 50. Could be wrong though.

% ... sometimes in life, just check that you input the function correctly.
% increment the counter of "do correct mathematics."
% ... max curvature is like 2.15e-5? ... Not greater than that?