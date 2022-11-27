function test_d = finding(d)

% % Constants
% m = 50*.001;    % kg
% L0 = 10*.01;    % m
% B = 12*.01;     % m
% k = 950;        % N/m

% step length
h0 = 1e-8;

% initial conditions
z = d;
zp = 0;

terminal_velocity_vector = [];
max_iter = 10;
for iter = 1:max_iter
    h = h0 * .5^iter;
    while z > 0
        [z, zp] = Euler_band(z, zp, h);
    end
    terminal_velocity_vector(end + 1) = zp;
end
terminal_velocity_vector'

% new step length
h0 = 1e-2;

final_position_vector = [];
max_iter = 10;
for iter = 1:max_iter

    % set initial conditions for trajectory
    v = zp;
    phi = pi/4;
    x = 0;
    xp = v * cos(phi);
    y = 1.65;
    yp = v * sin(phi);

    x_vec = [x];
    y_vec = [y];
    h = h0 * .5^iter;
    % task a
    while y_vec(end) > 0
        % Explicit euler
        [new_x,new_xp,new_y,new_yp,new_v] = System_euler_B(x,xp,y,yp,v,h);
    
        % update variables
        x = new_x;
        xp = new_xp;
        y = new_y;
        yp = new_yp;
        v = new_v;
    
        % fill lists
        x_vec(end + 1) = x;
        y_vec(end + 1) = y;
    end
    plot(x_vec, y_vec, 'b-')
    hold on
    
    % linear interpolation for final x value
    gradient = (y_vec(end) - y_vec(end - 1)) / (x_vec(end) - x_vec(end - 1));
    
    line = @(t) y_vec(end - 1) + gradient*(t - x_vec(end - 1));
    plot(linspace(x_vec(end-1), x_vec(end)), line(linspace(x_vec(end-1), x_vec(end))), 'r-')
    final_position = fzero(line,[x_vec(end - 1), x_vec(end)]);
    final_position_vector(end + 1) = final_position;
end
final_position_vector'
test_d = final_position_vector(end);
end