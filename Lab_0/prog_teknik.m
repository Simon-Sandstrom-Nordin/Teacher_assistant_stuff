clc; clear all; close all;

m = @(x) trick(x, 5);
disp(m(3))

a = 13; b = 23; c = 31;
[function_value, derivative_value] = test_function(a,b,c,0)

function value = trick(x,y)
value = x + 2*y;
end

% så: anonyma functioner kan användas då du vill anropa en "vanlig"
% funktion med vissa parametrar fixa. ... kanske användbart.
