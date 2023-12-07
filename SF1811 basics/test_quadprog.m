clear; close all; clc;

% X = quadprog(H,f,A,b,Aeq,beq,LB,UB)
% https://www.youtube.com/watch?v=GZb9647X8sg
X = quadprog(2.*[.4, 0; 0, 1], [-5, -6]', [1, -1; -.3, -1], [-2, -8]', ...
    [], [], [0, 0]', [10, 10]')

% X = linprog(f,A,b,Aeq,beq,LB,UB)
