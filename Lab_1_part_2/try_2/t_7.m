clc; clear; close all; format long;
% Integral med förbehandling
% Goal: numeric approximation within 1e-9 tolerance.
integrand = @(x) (1 - exp(-(x./7).^3)) ./ (3.*x.^3);

% Ceriet Gabriel Olof
% Gustav Karlander

% Robin gunnarson
% Erik Gelfsgren

% Johan Liu
% Axel Ström

% Mats "David" Hapanees
% Anderw mc pheson

% Markkus Lindgren
% Anton yakubenko

% Cassandra Oscarson
% Lykke Throne-Holst

% a. Plot from x = 0 to x = 50
figure(1)
x_vector = linspace(0, 2*10^(-4)); figure(1);
plot(x_vector, integrand(x_vector))
figure(4)
x_vector = linspace(30, 100);
plot(x_vector, integrand(x_vector))
hold on % let's plot our comparison integrand
plot(x_vector, 1./ x_vector.^3); legend("integrand", "comp")
% Why does it fluctuate so much in the beginning?
% It should be smooth, the integrand is a composition of
% continuous functions. ... but it's almost a division by
% zeros in the very beginning. 
figure(2); image(imread('geogebra_fluctuations.png'))
figure(3); image(imread('geogebra_fluctuations_2.png'))
% It has to have to with machine error of some kind, right?
% Both geogebra and Matlab struggle to evaluate the integrand
% near the vertical asymptot at x = 0.
% Thought: Analytically you *should* be able to punch in
% something like x = 1e-6. That'd get you something like
% 1/ 1e-18. But that's below machine epsilon, around 2e-16
% also 1e+18 is hella large, but maybe Matlab can deal with
% that, I don't know. But the division should be problematic.
% So it defaults to setting the value to zero? And then
% it freaks out? ... I'll have to ask around.

% never mind, it becomes someting close to 0 / 0. Idk.
% you never now what smallest of things make all the
% difference. I can quantify the smallness: 1/375.
% Putting that value in the trapezoid rule is easiest,
% otherwise do an integral estimation. abs(Imax - Imin).
% Also focus on the bright side of life. Egao wo Dozo.
% b. Comparison integral is 1 / 3x^3. 
% E <= 1 / (6B^2).
% B = 1e+5 gives E <= 1/6e+10
% Don't be too greedy maybe, we're approaching eps.

% c. Set it equal to ... it looks alot (especially in Geogebra)
% like the fluctuations cancel out. And I have no clue what
% happens around abs(x) < .2*1e-4, but judging from the
% behavious in geogebra I'd maybe make the bold claim it's
% a straight line of y = 1. It's essentially 0 / 0.

B = 1e+5;
x_vector = linspace(0, B); figure(5);
plot(x_vector, integrand(x_vector))

% Solution to the fluctuation
% now, this might not be very mathematical, but especially in 
% Geogebra it looks like a fluctuating pattern which cancels
% out around the line y = 1*e-3. SO, let's take the integral from
% 1*e-4 to B and add (1e-4 * 1e-3 = 1e-7 later.) The error
% resulting from this is probably zero.

% d. Do I need to do more? Unfortunately yes. If I just take the
% integral from 1e-4 to B then that's a very inefficient way,
% since most of the shit is in the interval up to like 1e+4.
% So how about this:
% int = int(f, 1e-4, 1e+4) + int(f, 1e+4, B) + start_shit + end_shit
% The assumption here is that start_shit is 0, that'a claim I make.

% e. Actually compute the integral.
% start with the main shit.
max_points = 4e+8;
y_list = integrand(linspace(1e-4, 1e+4, max_points));
h1 = abs(1e-4 - 1e+4) / length(y_list);   % minumum step length
trapz_1 = e_07_trapz(y_list, h1, 1)

% now the small shit
y_list = integrand(linspace(1e+4, B, max_points));
h2 = abs(1e+4 - B) / length(y_list);   % minumum step length
trapz_2 = e_07_trapz(y_list, h2, 1)

value = trapz_1 + trapz_2 + (1e-3 * 1e-4) + 0


tail = @(x) 1 ./ (3.*x.^3);
y_list = integrand(linspace(1e-4, 1e+4));
y_list_2 = tail(linspace(1e+4, B));
y_list = [y_list; y_list_2];
n = length(y_list); h = abs(B - 1e-4)/ n;

% f. We have a value. How certain is it?
T_h = value
h1_2 = 2*h1; h2_2 = 2*h2;
T_h2 = trapz_generator(h1_2, B, max_points, 2) + trapz_generator_2(h2_2, B, max_points, 2) + (1e-3 * 1e-4) + 0
h1_4 = 4*h1; h2_4 = 4*h2;
T_h4 = trapz_generator(h1_4, B, max_points, 4) + trapz_generator_2(h2_4, B, max_points, 4) + (1e-3 * 1e-4) + 0
quotient = abs(T_h4 - T_h2) / abs(T_h2 - T_h)

function new_value_1 = trapz_generator(h, B, max_points)
integrand = @(x) (1 - exp(-(x./7).^3)) ./ (3.*x.^3);
y_list = integrand(linspace(1e-4, 1e+4, max_points));
new_value_1 = e_07_trapz(y_list, h);
end

function new_value_2 = trapz_generator_2(h, B, max_points)
integrand = @(x) (1 - exp(-(x./7).^3)) ./ (3.*x.^3);
y_list = integrand(linspace(1e+4, B, max_points));
new_value_2 = e_07_trapz(y_list, h);
end