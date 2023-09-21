clc; clear all; close all;

% no. elements
n = 10;

% functions 'n shit
a = @(x) exp(x);
f = @(x) exp(x);
g = 1;

% parameters
x0 = 0; xend = 1;
h = (xend - x0) / n;

% stiffness matrix
A = zeros(n,n);

top = (-1/h)*ones(n-1,1);
mid = (2/h)*ones(n,1);
bot = (-1/h)*ones(n-1,1);

A = diag(top, 1) + diag(mid, 0) + diag(bot, -1)

