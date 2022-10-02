function volume = t_9_new(L)
% new try without the built-in ode45...
yp = @(x, y) - ( (1/6) + (pi*sin(pi.*x)) ./ (1.6 - cos(pi.*x))).*y;
y0 = 2.6; x0 = 0;
%L = L;  % our upper bound for x.
% This is now a dumb assignment, but I want it reminding how the code lokd.

% just to see what it looks like, and to compare
figure(1)
[x_list, y_list] = ode45(yp, linspace(x0, L), y0);
plot(x_list, y_list)

% Volume calculation
volume_integrand = @(y) pi.* y.^2;

volume = trapz(volume_integrand(y_list));

% Euler h = .1
x_list = [x0]; y_list = [y0]; h = .1;
while x_list(end) < L
    y_list(end + 1) = explicit_euler(yp, x_list(end), y_list(end), h);
    x_list(end + 1) = x_list(end) + h;
end
hold on;
plot(x_list, y_list)

% Euler h = h / 2
x_list = [x0]; y_list = [y0]; h = h / 2;
while x_list(end) < L
    y_list(end + 1) = explicit_euler(yp, x_list(end), y_list(end), h);
    x_list(end + 1) = x_list(end) + h;
end
hold on;
plot(x_list, y_list)

% Can I define a function within a function? Inception.
function y_new = explicit_euler(fun, x, y, h)
    y_new = y + h*fun(x,y);
end

end