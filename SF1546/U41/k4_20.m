clc; clear all; close all;

x = [.1, .2, .05, .3, .4, .05, .5];
y = [.1, .2, .05, .01, .02, .4, .5];
R = [.21, .48, .09, .39, .6, .14, 1.44];

lnx = log(x); lny = log(y); lnR = log(R);

A = [ones(1,7)', lnx', lny'];

c = A \ lnR'
mod_R = exp(c(1)).*x.^c(2).*y.^c(3);
plot(R, mod_R, 'ro-');