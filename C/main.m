clc; clear all; close all; format long;

d0 = .2;
test = @(d) finding(d) - 4;

fzero(test, d0)


figure(2)
% next for c, vary phi
phi_0 = pi/6;

phi_vector = 0:.01:pi/2;
distance_vector = zeros(length(phi_vector), 1);
for index = 1:length(phi_vector)
    distance_vector(index) = finding_phi(phi_vector(index));
end
figure(3)
plot(phi_vector, distance_vector)

% find index for maximum value
index = 1;
while distance_vector(index + 1) > distance_vector(index)
    index = index + 1;
end
distance_vector(index-1)
distance_vector(index)
distance_vector(index+1)
% spline might not be best for finding maximum value...
% polyfit
p = polyfit(phi_vector(index-1:index+1), distance_vector(index-1:index+1), 2);
second = @(t) p(1).*t.^2 + p(2).*t + p(3);
time = linspace(distance_vector(index-1), distance_vector(index+1));
hold on
plot(time, second(time))

% to find max... 
second_p = @(t) 2*p(1).*t + p(2);
fzero(second_p, [phi_vector(index-1), phi_vector(index+1)])

function final_position = finding_phi(phi)

% % Constants
% m = 50*.001;    % kg
% L0 = 10*.01;    % m
% B = 12*.01;     % m
% k = 950;        % N/m

% step length
h0 = 1e-8;

% initial conditions
z = .05;
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
    %phi = pi/4;
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
end