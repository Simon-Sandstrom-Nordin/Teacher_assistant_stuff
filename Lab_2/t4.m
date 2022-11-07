% Icke-linjärt cirkelproblem.
clc; clear all; close;

% givna värden
x = [7, 9, 4]; x1 = x(1); x2 = x(2); x3 = x(3);
y = [9, 2, 9]; y1 = y(1); y2 = y(2); y3 = y(3);

% factor
factor = 1;

f = @(v) [(x1 - v(1)).^2 + (y1 - v(2)).^2 - v(3).^2;
    (x2 - v(1)).^2 + (y2 - v(2)).^2 - v(3).^2;
    factor .* ( (x3 - v(1)).^2 + (y3 - v(2)).^2 - v(3).^2 )];

J = @(v) [-2.*(x1 - v(1)), -2.*(y1 - v(2)), -2.*v(3);
    -2.*(x2 - v(1)), -2.*(y2 - v(2)), -2.*v(3);
    factor .* ( -2.*(x3 - v(1)) ), factor .* (-2.*(y3 - v(2))), factor .*(-2.*v(3))];

% startvektor
X0 = 0; Y0 = 0; R0 = -2;
v = [X0, Y0, R0]';

v = Newton(v, f, J)
circle(v(1), v(2), v(3));

% stolen from internet
function h = circle(x,y,r)
hold on
th = 0:pi/50:2*pi;
xunit = r * cos(th) + x;
yunit = r * sin(th) + y;
h = plot(xunit, yunit); axis equal;
hold off
end

function v = Newton(v,f,J)
t = [1,1,1];
iter = 1; max_iter = 1000;
while norm(t) > 1e-9 %&& iter < max_iter
    f_v = f(v);
    J_m = J(v);
    t = J_m \ f_v;
    v = v - t;
    iter = iter + 1;
end
%X = v(1); Y = v(2); R = v(3);
end
