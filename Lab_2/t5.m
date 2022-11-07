%
clc; clear; close all;

h = 0.01;
first_list = [];
second_list = [];

for iteration = 1:8

    h = h/2;

    k = linspace(1,4, (4-1) / h);
    
    
    f_list = [];
    for c = 1:length(k)
        integrand = @(x) exp(.5.*(k(c).*x)./(3.*k(c) + x));
        f = @(k) integral(integrand, 1, 4*k) - 7.*(2 - k).^4;
    
        f_list(end+1) = f(k(c));
    end
    
    plot(k, f_list)
    
    index_list = [];
    i = 2;
    for j = 1:2
        while f_list(i) * f_list(i+1) > 0
            i = i + 1;
        end
        i = i + 1;
        index_list(end + 1) = i;
    end
    
    for c = 1:2
        i = index_list(c);
        point_before = i - 1; 
        point_after = i;
        disp(k(point_before) + " " + f_list(point_before))
        disp(k(point_after) + " " + f_list(point_after))
    
        gradient = (f_list(point_after) - f_list(point_before)) / (k(point_after) - k(point_before));
        y0 = f_list(point_before); t0 = k(point_before);
        line = @(t) y0 + gradient.*(t - t0);
        test_t = linspace(k(point_before) - .2, k(point_after) + .2);
        hold on
        plot(test_t, line(test_t))
    
        % interval halvation
        x_low = test_t(1); x_high = test_t(end);
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
        hold on
        
        first_list(end + 1) = x_mid;
    end
    

end

new_first = [];
for k = 2:2:length(first_list)
    new_first(end + 1) = first_list(k-1);
    second_list(end + 1) = first_list(k);
end

if mod(length(first_list), 2) == 1
    new_first(end + 1) = first_list(end);
end

new_first'
second_list'

% secant method
% first root
%root_1 = [];
%x0 = 1; x1 = 1.5; error = 1;
%while error > 1e-4
%    x2 = x1 - 
%end

% nvm, I'll just copy the code with interval halvation
% Interval halvation
% x_low = 1; x_high = 1.5;
% error = 1;
% while error > .00001
%     x_mid = (x_high + x_low)/2;
% 
%     low = line(x_low);
%     mid = line(x_mid);
%     high = line(x_high);
% 
%     if high*mid < 0
%         x_low = x_mid;
%     else
%         x_high = x_mid;
%     end
%     error = x_high - x_low;
% end
% disp(x_mid)
% 
% x_low = 2.5; x_high = 2.8;
% error = 1;
% while error > .00001
%     x_mid = (x_high + x_low)/2;
% 
%     low = line(x_low);
%     mid = line(x_mid);
%     high = line(x_high);
% 
%     if high*mid < 0
%         x_low = x_mid;
%     else
%         x_high = x_mid;
%     end
%     error = x_high - x_low;
% end
% disp(x_mid)
% nvm secant might be better here.
