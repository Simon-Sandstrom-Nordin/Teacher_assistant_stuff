clc; clear all; close all; format long;
% Uppgift 8
yp = @(x,y) -(1/6 + pi .* sin(pi.*x) ./ (1.5 - cos(pi.*x))).*y;
t = linspace(0,4,.5);
y0 = 2.5;
max_iter = 18;
L = 2.047140011526089;
%L = 4;
h0 = .5;
% 8.290204506440313

figure("Name","ode45")
ode45(yp,[0,4],y0)

figure("Name","Euler")
last_y_vector = [];
for iter = 1:max_iter
    h = h0 * .5^(iter-1);
    x_list = [0];
    y_list = [y0];
    for k = h:h:L
            k_1 = yp(k,y_list(end));
            k_2 = yp(k+0.5*h,y_list(end)+0.5*h*k_1);
            k_3 = yp((k+0.5*h),(y_list(end)+0.5*h*k_2));
            k_4 = yp((k+h),(y_list(end)+k_3*h));
            y_list(end+1) = y_list(end) + (1/6)*(k_1+2*k_2+2*k_3+k_4)*h;  % main equation
        %y_list(end + 1) = y_list(end) + h*yp(x_list(end),y_list(end));
        x_list(end + 1) = k;
    end
    plot(x_list, y_list)
    hold on
    last_y_vector(end+1) = y_list(end);
end
last_y_vector'
% Uppgift 9
V = @(y) pi .* y.^2;
vol_list = [];
for iter = 1:max_iter
    h = h0 * .5^(iter-1);
    x_list = [0];
    y_list = [y0];
    for k = h:h:L
            k_1 = yp(k,y_list(end));
            k_2 = yp(k+0.5*h,y_list(end)+0.5*h*k_1);
            k_3 = yp((k+0.5*h),(y_list(end)+0.5*h*k_2));
            k_4 = yp((k+h),(y_list(end)+k_3*h));
            y_list(end+1) = y_list(end) + (1/6)*(k_1+2*k_2+2*k_3+k_4)*h;  % main equation
        %y_list(end + 1) = y_list(end) + h*yp(x_list(end),y_list(end));
        x_list(end + 1) = k;
    end

    vol = trapz(x_list, V(y_list));
    vol_list(end+1) = vol;
end
vol_list'


