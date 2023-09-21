clc; clear all; close all;

% Icke-linjärt cirkelproblem.
clc; clear all; close;

% givna värden
x = [8, 11, 4]; x1 = x(1); x2 = x(2); x3 = x(3);
y = [10, 2, 8]; y1 = y(1); y2 = y(2); y3 = y(3);

for factor = 1:3:4
f = @(v) [(x1 - v(1)).^2 + (y1 - v(2)).^2 - v(3).^2;
    (x2 - v(1)).^2 + (y2 - v(2)).^2 - v(3).^2;
    factor.*((x3 - v(1)).^2 + (y3 - v(2)).^2 - v(3).^2)];

J = @(v) [-2.*(x1 - v(1)), -2.*(y1 - v(2)), -2.*v(3);
    -2.*(x2 - v(1)), -2.*(y2 - v(2)), -2.*v(3);
    factor.*(-2.*(x3 - v(1))), factor.*(-2.*(y3 - v(2))), factor.*(-2.*v(3))];

%factor = 1
% v =
% 
%    7.815789473684211
%    5.368421052631579
%    4.636561994013793

% factor 4
% v =
% 
%    7.815789473684211
%    5.368421052631579
%    4.636561994013793

% startvektor
X0 = 0; Y0 = 0; R0 = -1;
v = [X0, Y0, R0]';

v = Newton(v, f, J)
circle(v(1), v(2), v(3));
hold on
plot(x,y, 'o')
end

% d
disp("D question")
% givna värden
x = [8, 11, 4, 11]; x1 = x(1); x2 = x(2); x3 = x(3); x4 = x(4);
y = [10, 2, 8, 10]; y1 = y(1); y2 = y(2); y3 = y(3); y4 = y(4);

for factor = 1:3:4
f = @(v) [(x1 - v(1)).^2 + (y1 - v(2)).^2 - v(3).^2;
    (x2 - v(1)).^2 + (y2 - v(2)).^2 - v(3).^2;
    factor.*((x3 - v(1)).^2 + (y3 - v(2)).^2 - v(3).^2);
    (x4 - v(1)).^2 + (y4 - v(2)).^2 - v(3).^2];

J = @(v) [-2.*(x1 - v(1)), -2.*(y1 - v(2)), -2.*v(3);
    -2.*(x2 - v(1)), -2.*(y2 - v(2)), -2.*v(3);
    factor.*(-2.*(x3 - v(1))), factor.*(-2.*(y3 - v(2))), factor.*(-2.*v(3));
    -2.*(x4 - v(1)), -2.*(y4 - v(2)), -2.*v(3);];

%factor = 1
% v =
% 
%    8.341294298921417
%    5.796610169491525
%    4.687765669242520

% % factor 4
% v =
% 
%    8.206792777300086
%    5.773000859845228
%    4.750338882642926

% startvektor
X0 = 0; Y0 = 0; R0 = -1;
v = [X0, Y0, R0]';

v = Newton(v, f, J)
circle(v(1), v(2), v(3));
hold on
plot(x,y, 'o')
end

% h, multiply third equation
%f(3) = 3*f(3);
%A(3,:) = 3 * A(3,:);
% 6.7896 5.8995 4.3498

% f
x = [8, 11, 4];
y = [10, 2, 8];
c1_column = ones(1,3)';
c2_column = x';
c3_column = y';
f = [x.^2 + y.^2]';
A = [c1_column, c2_column, c3_column];
v = A \ f;
X = v(2) / 2; Y = v(3) / 2; R = sqrt(v(1) + (v(2)/2).^2 + (v(3)/2).^2);
disp(X + " " +  Y + " " + R)
circle(X, Y, R);
% 7.8158 5.3684 4.6352

% g
disp("Question G")
A = [c1_column, c2_column, c3_column];
A(3,:) = 4*A(3,:); f(3) = f(3) * 4;
v = A \ f;
X = v(2) / 2; Y = v(3) / 2; R = sqrt(v(1) + (v(2)/2).^2 + (v(3)/2).^2);
disp(X + " " +  Y + " " + R)
circle(X, Y, R);
% 7.8158 5.3684 4.6352

function v = Newton(v,f,J)
t = [1,1,1];
iter = 1e-12; max_iter = 1000;
while norm(t) > 1 && iter < max_iter
    f_v = f(v);
    J_m = J(v);
    t = J_m \ f_v;
    v = v - t;
    iter = iter + 1;
    if iter == max_iter
        disp("Max iterations hit")
    end
end
%X = v(1); Y = v(2); R = v(3);
end

function h = circle(x,y,r)
hold on
th = 0:pi/50:2*pi;
xunit = r * cos(th) + x;
yunit = r * sin(th) + y;
h = plot(xunit, yunit); axis equal;
hold off
end
