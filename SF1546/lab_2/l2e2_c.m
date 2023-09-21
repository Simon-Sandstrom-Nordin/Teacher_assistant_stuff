clc; clear all; close all; format long;
yp = @(x,y) -((1/7) + (pi*sin(pi*x)) / (1.6 - cos(pi*x)))*y;

% parameters
y0 = 2.5;
n = 30;
x0 = 0;
L = 4;

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

fi = 0:2*pi/30:2*pi; x = linspace(0,4,length(fi));
X = x'*ones(size(fi)); Y = y_list'*cos(fi); Z = y_list'*sin(fi);
mesh(X,Y,Z)