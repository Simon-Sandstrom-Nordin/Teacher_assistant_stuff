function approx_int = e_07_trapz(y_list, h)
approx_int = 0; % place-holder value

% add endpoints
% y_list; remains since testing
approx_int = approx_int + (h/2)*(y_list(1) + y_list(end));

% add intermediary points
for k = 2: length(y_list) - 1   % minus one since discluding end point.
    approx_int = approx_int + y_list(k)*h;
end

end
