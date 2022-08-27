% Use MATLAB to solve a linear system of equations. Ez.

% all programs typically start with this next line to clear the command
% terminal, clear the workspace, and close all open figures
clc; clear all; close all;
% ... although MATLAB complains about the clear "all" part.

A = [1, 1, 1, -1;
    1, 1, 1, 1;
    1, 2, 4, 8;
    1, 4, 16, 64];

b = [4, 2, -2, 14]';

x = A \ b;
disp("x is "); disp(x);

disp("A * x is "); disp(A*x);

disp("A * x is supposed to be "); disp(b);

% The backslash operator in MATLAB can also be used for a least square
% approximation in the case that the system is over-determined, i.e. the
% matrix operating on the vector has more rows than the vector being
% transformed, i.e. there are more equations than unknowns. More on that in
% future excercises.
