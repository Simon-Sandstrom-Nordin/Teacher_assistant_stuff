clc; clear all; close all;

yp = @(x,y) -((1/7) + (pi*sin(pi*x)) / (1.6 - cos(pi*x)))*y;

% parameters
y0 = 2.5;
h = .5;
x0 = 0;
xn = 4;

disp(["y", "h", "iter"])
for j = 1:12
    n = abs((xn-x0)/h);
    
    % lists
    y_list = [y0];
    for k = 1:n
        y_new = y_list(end) + h*yp((k-1)*h, y_list(end));
        y_list(end+1) = y_new;
    end
    hold on;
    plot(x0:h:xn, y_list)
    h = h/2;
    disp([y_list(end), h, j-1])
end
