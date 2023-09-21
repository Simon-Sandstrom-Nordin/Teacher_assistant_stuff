clc; clear all; close all;

% interval
a = 0; b = 1;

% boundry conditions
ya = 1; yb = 3;


% number of steps (between boundry points)
n = 1;
for k = 1:10
    figure(k)
    % parameters
    h = (b-a)/(n+1);
    alpha = 4*(1/6)*h + 2/h; beta = (2/3)*h - 1/h;
    
    % loading stiffness and load vector
    e = ones(n,1);
    M = spdiags([beta*e alpha*e beta*e], -1:1, n, n);
    d = zeros(n,1);
    d(1) = -ya*beta; d(n) = -yb*beta;
    
    % calc.
    c = M\d;
    c = [1; c; 3];
    hold on;
    plot(0:h:h+n*h, c, 'bo')
    n = n*2;
end

