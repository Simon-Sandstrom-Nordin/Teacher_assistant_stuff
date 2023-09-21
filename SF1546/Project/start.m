clc; clear all; close all;

guess = 6;
x = fzero(@solver,guess)
% 23.029718527972499


function F = solver(guess)
% a. Where does it land? (measured horizontally from the starting point)
% starting conditions
% first run
b = 2*pi*guess/(360);  % degrees in radians from vertical axis
y = .1; % meters
x = 0;
m = .25;    % kg at start
v = 0;
t = 0;
h = .01;
max_iter = 6500;

t_list = zeros(1,max_iter); v_list = zeros(1,max_iter);
x_list = zeros(1,max_iter); y_list = zeros(1,max_iter);
t_list(1) = t; v_list(1) = v;
x_list(1) = x; y_list(1) = y;
for k = 2:max_iter
    [x,y,v,b,m,t] = System_RK4(x,y,v,b,m,t,h);
    x_list(k)=x; y_list(k)=y;
    t_list(k)=t; v_list(k)=v;
end
% find index of maximum
[m,i] = max(y_list);
F = m - 400;
end