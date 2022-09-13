function integral_approximation = trapezoid_test_func(func, x_interval ,h)
integral_approximation = 0;                         % place holder for now.

% variables
interval_length = abs(x_interval(2) - x_interval(1));
number_of_points = ceil(interval_length / h) + 1;       % h is size of dx.
                                                    % + 1 since we're
                                                    % including one but not
                                                    % two of our endpoints.
% lists (numerical arrays)
x_list = linspace(x_interval(1), x_interval(2), number_of_points);
y_list = func(x_list);

 % add endpoint values
integral_approximation = integral_approximation + (h/2)*(y_list(1) + y_list(end));

% add intermediate values
for k = 2: length(y_list) - 1   % minus one since discluding end point.
    integral_approximation = integral_approximation + y_list(k)*h;
end

% forget this part
% multiply by 2*dx in order to do correct mathematics
% integral_approximation = 2*h*integral_approximation;

% note on linspace(start, end, # of points):
% linspace(x, y, 1) gives you [y].

% mistakes were made regarding adding terms, but it's ok now.
% also multiplying everything by h.
end
