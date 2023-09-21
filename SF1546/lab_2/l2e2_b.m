clc; clear all; close all; format long;

V = @(y, h) pi*l2_trapz(y.^2, h);
yp = @(x,y) -((1/7) + (pi*sin(pi*x)) / (1.6 - cos(pi*x)))*y;
V_L4 = 14.001751755638018;  
V_saught = V_L4 *.75;
% within relative error of 1e-12, so around 10 corr. decim.
% 14.001751755683067   0.000012207031250  15.000000000000000
% 14.001751755646197   0.000006103515625  16.000000000000000
% 14.001751755638018   0.000003051757813  17.000000000000000

L_list = []; V_list = [];
for L = 1:.1:4
    % parameters
    y0 = 2.5;
    n = 10;
    x0 = 0;
    
    disp(["V", "h", "iter"])
    j = 1; volume = 10; old_volume = 9; tol = 1e-8;
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
        
        %hold on;
        %plot(x0:h:xn, y_list)
        disp([volume, h, j-1])
    
        % increments
        n = n*2;
        j = j+1;
    end

    L_list(end + 1) = L; V_list(end + 1) = volume;
end

plot(L_list, V_list, 'bo'); hold on; yline(V_saught, 'Color', 'red');

% Interpolation
% step 1: lower all values by V_saught so that this becomes a root problem
V_altered = V_list - V_saught;
index = 1;
while V_altered(index) * V_altered(index+1) > 0
    index = index + 1;
end
% index is just before saught value
% linear int.
slope=(V_altered(index+1)-V_altered(index))/(L_list(index+1)-L_list(index));
line = @(x) V_altered(index) + slope * (x - L_list(index));
% quadratic int.
A = [ones(3,1), [L_list(index-1); L_list(index); L_list(index+1)], [L_list(index-1); L_list(index); L_list(index+1)].^2];
coeff = A \ [V_altered(index-1), V_altered(index), V_altered(index+1)]';
quadr = @(x) coeff(1) + coeff(2) .* x + coeff(3) * x.^2;

% interval halvation to find roots of lin. and quad. int.
x_low = L_list(index); x_high = L_list(index+1);
error = 1;
while error > .00001
    x_mid = (x_high + x_low)/2;

    low = line(x_low);
    mid = line(x_mid);
    high = line(x_high);

    if high*mid < 0
        x_low = x_mid;
    else
        x_high = x_mid;
    end
    error = x_high - x_low;
end
disp(x_mid)

error = 1;
while error > .00001
    x_mid = (x_high + x_low)/2;

    low = quadr(x_low);
    mid = quadr(x_mid);
    high = quadr(x_high);

    if high*mid < 0
        x_low = x_mid;
    else
        x_high = x_mid;
    end
    error = x_high - x_low;
end
disp(x_mid)

