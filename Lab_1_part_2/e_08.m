% Säker integral
clc; clear all; close all;

integrand = @(x) 132.*exp(-((14.*x - pi)./.004).^2);

% a. Approximate the integral with MATLAB's quad function.
% show what accuracy you have and why you can be sure of
% your value (at least 8 correct digits are required).

% b. How do you minimize the amount of neccessary work?
% It depends on the way you divide the interval, i.e. how
% many data points you use.
