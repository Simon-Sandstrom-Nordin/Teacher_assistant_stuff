% Icke-linjärt cirkelproblem.
clc; clear all; close;

% givna värden
x = [7, 9, 4, 10, 2]; x1 = x(1); x2 = x(2); x3 = x(3); x4 = x(4);x5 = x(5);
y = [9, 2, 9, 10, 9]; y1 = y(1); y2 = y(2); y3 = y(3); y4 = y(4);y5 = y(5);



c1_column = ones(1,5)';
c2_column = x';
c3_column = y';
f = [x.^2 + y.^2]';
A = [c1_column, c2_column, c3_column];

% h, multiply third equation
%f(3) = 3*f(3);
%A(3,:) = 3 * A(3,:);
% 6.7896 5.8995 4.3498


v = A \ f;
X = v(2) / 2; Y = v(3) / 2; R = sqrt(v(1) + (v(2)/2).^2 + (v(3)/2).^2);
disp(X + " " +  Y + " " + R)
circle(X, Y, R);
% 6.4873 5.9676 4.5788

function h = circle(x,y,r)
hold on
th = 0:pi/50:2*pi;
xunit = r * cos(th) + x;
yunit = r * sin(th) + y;
h = plot(xunit, yunit); axis equal;
hold off
end