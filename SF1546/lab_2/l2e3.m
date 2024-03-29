clc; clear all; close all;

% Begynnelsevärdesproblem för system
clc; clear; close; format long;

L = 2.5;

up = @(t, u) [u(2);
    -(9.81/L)*sin(u(1))];

u1_0 = 5 * pi / 7;
u2_0 = .8;

u = [u1_0; u2_0];   % Initial vector

T = pi+1;
t = linspace(0, 2*T, 2^(5)*100);

[t_v, U] = ode45(up, t, u)
figure(2)
plot(t_v, U(:,1));
hold on
plot(t_v, U(:, 2));
legend("Angle", "Angular speed")

phi = U(:,1);
phi = phi - phi(1);
i = 2;
for j = 1:2
    while phi(i) * phi(i+1) > 0
        i = i + 1;
    end
    i = i + 1;
end
i = i - 1; % compensation
point_before = i; 
point_after = i + 1;
disp(t_v(point_before) + " " + phi(point_before))
disp(t_v(point_after) + " " + phi(point_after))

plot(t, phi)

gradient = (phi(point_after) - phi(point_before)) / (t_v(point_after) - t_v(point_before));
y0 = phi(point_before); t0 = t_v(point_before);
line = @(t) y0 + gradient.*(t - t0);
test_t = linspace(t_v(point_before) - .2, t_v(point_after) + .2);
hold on
plot(test_t, line(test_t))
% find roots of this line.
% Interval halvation
x_low = test_t(1); x_high = test_t(end);
error = 1;
while error > .000001
    x_mid = (x_high + x_low)/2;

    low = line(x_low);
    mid = line(x_mid);
    high = line(x_high);

    if high*mid < 0
        x_low = x_mid;
    else
        x_high = x_mid;
    end
    error = abs(x_high - x_low);
end
disp(x_mid)
hold on
% Ployfit with a third degree
P = polyfit([t_v(point_after-1), t_v(point_after), t_v(point_after+1)], ...
    [phi(point_after-1), phi(point_after), phi(point_after+1)], 2);
quad = @(t) P(1).*t.^2 + P(2).*t + P(3);
hold on
plot(test_t, quad(test_t))
% find roots of this parabola.
% Interval halvation
x_low = test_t(1); x_high = test_t(end);
error = 1;
while error > .000001
    x_mid = (x_high + x_low)/2;

    low = line(x_low);
    mid = line(x_mid);
    high = line(x_high);

    if high*mid < 0
        x_low = x_mid;
    else
        x_high = x_mid;
    end
    error = abs(x_high - x_low);
end
disp(x_mid)
% Can we do splines too?
%hold on
%plot(test_t, spline(t_v, phi))

% L = 2.5
% line:   4.843113739654493
% quad:   4.843113739654493

% L = 2.8
% line:   5.153647532592965
% quad:   5.153647532592965

%close all;
%anim(t_v, U(:,1), L)
% Taken from laboration instructions
function anim(tut,fiut,L)
for i=1:length(tut)-1
x0=L*sin(fiut(i));y0=-L*cos(fiut(i));
plot([0,x0],[0,y0],'-o')
axis('equal')
axis([-1 1 -1 1]*1.2*L)

drawnow
pause(tut(i+1)-tut(i))
end
end
