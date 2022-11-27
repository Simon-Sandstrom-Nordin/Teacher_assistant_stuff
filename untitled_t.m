clc; clear all; close all;
h = 1e-4;
L = 2.047139772147093;
yp = @(x,y) -(1/6 + pi .* sin(pi.*x) ./ (1.5 - cos(pi.*x))).*y;
V = @(y) pi .* y.^2;
x_list = [0];
y_list = [2.5];
for k = h:h:L
    k_1 = yp(k,y_list(end));
    k_2 = yp(k+0.5*h,y_list(end)+0.5*h*k_1);
    k_3 = yp((k+0.5*h),(y_list(end)+0.5*h*k_2));
    k_4 = yp((k+h),(y_list(end)+k_3*h));
    y_list(end+1) = y_list(end) + (1/6)*(k_1+2*k_2+2*k_3+k_4)*h;  % main equation
    %y_list(end + 1) = y_list(end) + h*yp(x_list(end),y_list(end));
    x_list(end + 1) = k;
end

vol = trapz(x_list, V(y_list))
% 8.289120812481576
% 11.833145844606353
