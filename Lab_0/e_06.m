% samma som i uppgift 5, fast med lite annan funktion.
clc; clear; close;

% array of input values, (inlet values?)
x = 0:.5:5;

% transpose x
x = x'

% anonomous function
g = @(x) x.^3 / 20 - 2 -x.^3.*exp(-x);
% note: remember the dots. We're pushing a vector of values through this
% black box function, and we want it to operate on every element
% individually. What happens if you omit the dot? ... 
% I think it works sometimes, but it becomes a vector operation.
% x * x ~= x .* x neccessarily. As seen in excercise 2.

% matrix <3
[x, g(x)]


