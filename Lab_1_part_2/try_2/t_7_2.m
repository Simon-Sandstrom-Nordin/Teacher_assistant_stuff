% Same thing as t_7 but with a lower B
clc; clear; close all; format long;
% Integral med förbehandling
% Goal: numeric approximation within 1e-9 tolerance.
integrand = @(x) (1 - exp(-(x./7).^3)) ./ (3.*x.^3);

B = 2e+4;
x_vector = linspace(0, B); figure(5);
plot(x_vector, integrand(x_vector))

% e. Actually compute the integral.
% (only) the main shit.
max_points = 6e+8;
y_list = integrand(linspace(1e-4, B, max_points));
h = abs(1e-4 - B) / length(y_list);   % minumum step length
trapz_1 = e_07_trapz(y_list, h, 1)

value = trapz_1 + (1e-3 * 1e-4) + 0;


tail = @(x) 1 ./ (3.*x.^3);

% f. We have a value. How certain is it?
T_h = value
h_2 = 2*h;
T_h2 = trapz_generator(h_2, B, max_points, 2) + (1e-3 * 1e-4) + 0
h_4 = 4*h;
T_h4 = trapz_generator(h_4, B, max_points, 4) + (1e-3 * 1e-4) + 0
quotient = abs(T_h4 - T_h2) / abs(T_h2 - T_h)

function new_value_1 = trapz_generator(h, B, max_points, n)
integrand = @(x) (1 - exp(-(x./7).^3)) ./ (3.*x.^3);
y_list = integrand(linspace(1e-4, B, max_points));
new_value_1 = e_07_trapz(y_list, h, n);
end
