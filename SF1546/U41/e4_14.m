clc; close all; clear all;

p = [10, 16, 25, 40, 60]; q = [94, 118, 147, 180, 230];

lnp = log(p); lnq = log(q); A = [ones(5,1), lnp'];
c = A \ lnq';
plot(p, q, 'ro'); hold on; 
q_f = @(x) exp(c(1)).*x.^c(2); p_lin = linspace(10, 60);
plot(p_lin, q_f(p_lin), 'b-');