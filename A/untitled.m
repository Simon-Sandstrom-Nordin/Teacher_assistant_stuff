h0 = 1e-2;

final_position_vector = [];
max_iter = 10;
for iter = 1:max_iter

    % set initial conditions for trajectory
    v = 13;
    phi = (5/360)*2*pi;
    x = 0;
    xp = v * cos(phi);
    y = 1.85;
    yp = v * sin(phi);

    x_vec = [x];
    y_vec = [y];
    h = h0 * .5^iter;
    % task a
    while x_vec(end) < 2.37
        % Explicit euler
        [new_x,new_xp,new_y,new_yp,new_v] = System_euler_A(x,xp,y,yp,v,h);
    
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
    plot(linspace(x_vec(end-1)-.1, x_vec(end)+.1), line(linspace(x_vec(end-1)-.1, x_vec(end)+.1)), 'r-')
    final_position = line(2.37)
    final_position_vector(end + 1) = final_position;
end
final_position_vector'
final_position = final_position_vector(end);
