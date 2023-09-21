clc; clear all; close all; format long;

V = @(y, h) pi*l2_trapz(y.^2, h);
yp = @(x,y) -((1/7) + (pi*sin(pi*x)) / (1.6 - cos(pi*x)))*y;

% parameters
y0 = 2.5;
n = 10;
x0 = 0;
L = 4;

disp(["V", "h", "iter"])
j = 1; volume = 10; old_volume = 9; tol = 1e-12;
while abs((volume-old_volume)/old_volume) > tol
    xn = L;
    h = abs((xn-x0)/n);
    
    % lists
    y_list = [y0];

    for k = 1:n
        k_1 = yp((k-1)*h,y_list(end));
        k_2 = yp((k-1)*h+0.5*h,y_list(end)+0.5*h*k_1);
        k_3 = yp((k-1)*h+0.5*h,(y_list(end)+0.5*h*k_2));
        k_4 = yp(((k-1)*h+h),(y_list(end)+k_3*h));
        y_list(end+1) = y_list(end) + (1/6)*(k_1+2*k_2+2*k_3+k_4)*h;
    end
    old_volume = volume;
    volume = V(y_list, h);
    
    hold on;
    plot(x0:h:xn, y_list)
    disp([volume, h, j-1])

    % increments
    n = n*2;
    j = j+1;
end

V_L4 = volume;  % within relative error of 1e-12, so around 10 corr. decim.

