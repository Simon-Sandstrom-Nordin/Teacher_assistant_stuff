% Integral med förbehandling
clc; clear all; close all; format long;


% notes:
% tolerance for error
tol = 1e-9;
% analytisk förbehandling: fiffla lite innan du utför
% numerisk integration med trapetsmetoden.
% inbyggda funktioner för jämförelse: quad, integral, trapz
% ... eller analytiska värdet.

% a. Plot the integrand.
integrand = @(x) (1 - exp(-(x./3).^3))./(5.*x.^3);
figure(1)
x = linspace(0, 1e-4, 100);
plot(x, integrand(x), 'b-')

% % Taylor
T = @(x) 1/135 - (x.^3)/7290 + (x.^6)/590490 - (x.^9)/63772920;% + (x.^12)/8609344200;
% hold on; plot(x, T(x), 'r-')
% error_taylor = abs(((1e-4).^12)/8609344200)/factorial(12);
% 
B = 10^6; % error bound 10^-13
 
x_vector = linspace(0, B); figure(5);
plot(x_vector, integrand(x_vector))
% 
% % d. Do I need to do more?
% 
% % e. Actually compute the integral.
max_points = 2e+7;
% y_list = T(linspace(0, 1e-4, max_points));
h1 = abs(0 - 1e-4) / max_points;   % minimum step length
% trapz_1 = e_07_trapz(y_list, h1)
% 
% % now the small
% y_list = integrand(linspace(1e-4, 1, max_points));
h2a = abs(1e-4 - 1) / max_points;   % minumum step length
% trapz_2a = e_07_trapz(y_list, h2a)
% 
% % now the small again
% y_list = integrand(linspace(1, 5, max_points));
h2ba = abs(1 - 2) / max_points;   % minumum step length
% trapz_2ba = e_07_trapz(y_list, h2ba)
% 
% % now the small again, again
% y_list = integrand(linspace(5, 10, max_points));
h2bb = abs(2 - 3) / max_points;   % minumum step length
% trapz_2bb = e_07_trapz(y_list, h2bb)
% 
% % tail
% y_list = integrand(linspace(10, 20, max_points));
h3 = abs(3 - 4) / max_points;   % minumum step length
% trapz_3 = e_07_trapz(y_list, h3)
% 
% % tail again, before
% y_list = integrand(linspace(20, 50, max_points));
h3a = abs(4 - 5) / max_points;   % minumum step length
% trapz_3a = e_07_trapz(y_list, h3a)
% 
% % tail again
% y_list = integrand(linspace(50, 10^2, max_points));
h3b = abs(5 - 10) / max_points;   % minumum step length
% trapz_3b = e_07_trapz(y_list, h3b)
% 
% % tail again, again
% y_list = integrand(linspace(10^2, B, max_points));
h3c = abs(10 - B) / max_points;   % minumum step length
% trapz_3c = e_07_trapz(y_list, h3c)
% 
% 
% value = trapz_1 + trapz_2a + trapz_2ba + trapz_2bb + trapz_3 + trapz_3b + trapz_3c

% test partition
trapz_generator(h1, B, max_points, 1)
trapz_generator_2a(h2a, B, max_points, 1)
trapz_generator_2ba(h2ba, B, max_points, 1)
trapz_generator_2bb(h2bb, B, max_points, 1)
trapz_generator_3(h3, B, max_points, 1)
trapz_generator_3a(h3a, B, max_points, 1)
trapz_generator_3b(h3b, B, max_points, 1)
trapz_generator_3c(h3c, B, max_points, 1)

T_h = trapz_generator(h1, B, max_points, 1) + trapz_generator_2a(h2a, B, max_points, 1) + trapz_generator_2ba(h2ba, B, max_points, 1) + trapz_generator_2bb(h2bb, B, max_points, 1) + trapz_generator_3(h3, B, max_points, 1) + trapz_generator_3a(h3a, B, max_points, 1) + trapz_generator_3b(h3b, B, max_points, 1) + trapz_generator_3c(h3c, B, max_points, 1)


% f. We have a value. How certain is it?
% T_h = value
h1_2 = 2*h1; h2a_2 = 2*h2a; h2ba_2 = 2*h2ba; h2bb_2 = 2*h2bb; h3_2 = 2*h3; h3a_2 = 2*h3a; h3b_2 = 2*h3b; h3c_2 = 2*h3c;
T_h2 = trapz_generator(h1_2, B, max_points, 1/2) + trapz_generator_2a(h2a_2, B, max_points, 1/2) + trapz_generator_2ba(h2ba_2, B, max_points, 1/2) + trapz_generator_2bb(h2bb_2, B, max_points, 1/2) + trapz_generator_3(h3_2, B, max_points, 1/2) + trapz_generator_3a(h3a_2, B, max_points, 1/2) + trapz_generator_3b(h3b_2, B, max_points, 1/2) + trapz_generator_3c(h3c_2, B, max_points, 1/2)
h1_4 = 4*h1; h2a_4 = 4*h2a; h2ba_4 = 4*h2ba; h2bb_4 = 4*h2bb; h3_4 = 4*h3; h3a_4 = 4*h3a; h3b_4 = 4*h3b; h3c_4 = 4*h3c;
T_h4 = trapz_generator(h1_4, B, max_points, 1/4) + trapz_generator_2a(h2a_4, B, max_points, 1/4) + trapz_generator_2ba(h2ba_4, B, max_points, 1/4) + trapz_generator_2bb(h2bb_4, B, max_points, 1/4) + trapz_generator_3(h3_4, B, max_points, 1/4) + trapz_generator_3a(h3a_4, B, max_points, 1/4) + trapz_generator_3b(h3b_4, B, max_points, 1/4) + trapz_generator_3c(h3c_4, B, max_points, 1/4)
quotient = abs(T_h4 - T_h2) / abs(T_h2 - T_h)

function new_value_1 = trapz_generator(h, B, max_points, f)
T = @(x) 1/135 - (x.^3)/7290 + (x.^6)/590490 - (x.^9)/63772920;
y_list = T(linspace(0, 1e-4, max_points*f));
new_value_1 = e_07_trapz(y_list, h);
end

function new_value_2a = trapz_generator_2a(h, B, max_points, f)
integrand = @(x) (1 - exp(-(x./3).^3))./(5.*x.^3);
y_list = integrand(linspace(1e-4, 1, max_points*f));
new_value_2a = e_07_trapz(y_list, h);
end

function new_value_2ba = trapz_generator_2ba(h, B, max_points, f)
integrand = @(x) (1 - exp(-(x./3).^3))./(5.*x.^3);
y_list = integrand(linspace(1, 2, max_points*f));
new_value_2ba = e_07_trapz(y_list, h);
end

function new_value_2bb = trapz_generator_2bb(h, B, max_points, f)
integrand = @(x) (1 - exp(-(x./3).^3))./(5.*x.^3);
y_list = integrand(linspace(2, 3, max_points*f));
new_value_2bb = e_07_trapz(y_list, h);
end


function new_value_3 = trapz_generator_3(h, B, max_points, f)
integrand = @(x) (1 - exp(-(x./3).^3))./(5.*x.^3);
y_list = integrand(linspace(3, 4, max_points*f));
new_value_3 = e_07_trapz(y_list, h);
end

function new_value_3a = trapz_generator_3a(h, B, max_points, f)
integrand = @(x) (1 - exp(-(x./3).^3))./(5.*x.^3);
y_list = integrand(linspace(4, 5, max_points*f));
new_value_3a = e_07_trapz(y_list, h);
end

function new_value_3b = trapz_generator_3b(h, B, max_points, f)
integrand = @(x) (1 - exp(-(x./3).^3))./(5.*x.^3);
y_list = integrand(linspace(5, 10, max_points*f));
new_value_3b = e_07_trapz(y_list, h);
end

function new_value_3c = trapz_generator_3c(h, B, max_points, f)
integrand = @(x) (1 - exp(-(x./3).^3))./(5.*x.^3);
y_list = integrand(linspace(10, B, max_points*f));
new_value_3c = e_07_trapz(y_list, h);
end
