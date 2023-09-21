clc; clear all; close all;
format long;

integrand = @(x,k) exp(x./7 + k./(3.*k + x));
% integrand = -27.*(10 - 7* + k.^2).^2;

n = 1000;
for j = 1:1
n = n*2;
k_list = [];
int_list = [];
for k = 1:.01/j:4
    % evaluate integral
    x = linspace(1,4*k, n);
    h = (4 * k - 1)/n;
    y_list = [];
    for j = 1:n
        y_list(end+1) = integrand(x(j),k);
    end
    int = l2_trapz(y_list, h); 
    % disp(quad(@(x) exp(x./7 + k./(3.*k + x)), 1, 4 * k))
    lhs = int - 27.*(10 - 7*k + k.^2).^2;
    int_list(end+1) = lhs;
    k_list(end+1) = k;
end
figure(1)
plot(k_list, int_list, 'o')

index = 1;
while int_list(index) * int_list(index+1) > 0
    index = index + 1;
end

% linear int.
slope=(int_list(index+1)-int_list(index))/(k_list(index+1)-k_list(index));
line = @(x) int_list(index) + slope * (x - k_list(index));
% quadratic int.
A = [ones(3,1), [k_list(index-1); k_list(index); k_list(index+1)], [k_list(index-1); k_list(index); k_list(index+1)].^2];
coeff = A \ [int_list(index-1), int_list(index), int_list(index+1)]';
quadr = @(x) coeff(1) + coeff(2) .* x + coeff(3) * x.^2;

% interval halvation to find roots of lin. and quad. int.
x_low = k_list(index); x_high = k_list(index+1);
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
disp("above values were for n = " + num2str(n))
end
