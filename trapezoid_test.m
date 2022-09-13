clc; close all; clear all;

func = @(x) x.^2;
x_interval = [0, 1];
h = 1/16;
approx = trapezoid_test_func(func, x_interval, h)
exact_ish = integral(func, x_interval(1), x_interval(2))
error = approx - exact_ish