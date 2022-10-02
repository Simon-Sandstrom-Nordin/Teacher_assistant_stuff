function approx_int = e_07_trapz(y_list, h, n)
% "n" is the factor by which I'm increasing the step length.
approx_int = 0; % place-holder value

% add endpoints
% y_list; remains since testing
approx_int = approx_int + (h/2)*(y_list(1) + y_list(2));

% add intermediary points
for k = 2:n: length(y_list) - 1   % minus one since discluding end point.
    approx_int = approx_int + y_list(k)*h;
end

end

% I'll steal this into this file.

% The error is here. The for-loop uses every point regardless of
% the step length. It doesn't adjust.