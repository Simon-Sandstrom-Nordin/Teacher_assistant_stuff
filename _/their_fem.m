clc; clear all; close all;

n = 10;
A = zeros(n,n);
h = 1/n;

a = @(x) 1 + x;
f = @(x) 0;

cm = 4/h^2;
c = -4/h^2;

top_lane;   % i to j
mid_lane;   % i-1 to i+1
bot_lane;   % j to i


