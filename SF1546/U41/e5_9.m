clc; clear all; close all;

x = [7.4, 12.8, 17.6, 21.5, 24, 27.1, 30.2, 32.5];
y = [4.2, 2.4, .6, 4, 6, 4.7, 1.8, -.6];
plot(x(1:2),y(1:2), 'ro-'); axis equal; hold on;
plot(x(2:5),y(2:5), 'ro'); axis equal; hold on;
plot(x(5:8),y(5:8), 'bo'); axis equal; hold on;

% gradient at x(2)
grad = (y(2) - y(1)) / (x(2) - x(1));

% hermite poly. with divided differences
x1 = x(2); x2 = x(2); x3 = x(3); x4 = x(3); x5 = x(4); x6 = x(4); x7 = x(5); x8 = x(5); 
f1 = y(2); f2 = y(2); f3 = y(3); f4 = y(3); f5 = y(4); f6 = y(4); f7 = y(5); f8 = y(5);
fp1 = -1/3; f12 = (y(2) - y(1))/(x(2) - x(1)); fp2 = 1/3; ...
    f23 = (y(3) - y(2))/(x(3) - x(2)); fp3 = 1; ...
    f34 = (y(4) - y(3))/(x(4) - x(3)); fp4 = 0; ...
    f123 = 0;

P = @(x) f1 + fp1.*(x-x1) + f12.*(x-x1).^2 + f123.*(x-x1).^2.*(x-x3) + ...
    (x-x1).^2.*(x-x3).^2 + (x-x1).^2.*(x-x3).^2.*(x-x5) + (x-x1).^2.*(x-x3).^2.*(x-x5).^2;
f12 = (f2 - f1) / (x2 - x1); f23 = (f3 - f2) / (x3 - x2); f34 = (f4 - f3) / (x4 - x3);
f123 = (f23 - f12) / (x3 - x1); f234 = (f34 - f23) / (x4 - x2);
f1234 = (f234 - f123) / (x4 - x1);

%x = [12.8, 17.6, 21.5, 24];
%y = [2.4, .6, 4, 6];
%yp = [-1/3, 1/3, 1, 0];

%A = [ones(4,1);zeros(4,1), x'; ones(4,1), x'.^2; 2.*x', x'.^3; 3.*x'.^2, x'.^4; 4.*x'.^3, x'.^5; 5.*x'.^4, x'.^6; 6.*x'.^5, x'.^7; 7.*x'.^6]


% cubic poly. with linear algebra
A = [1, x(5)-x(5), (x(5)-x(5))^2, (x(5)-x(5))^3;
    1, x(6)-x(5), (x(6)-x(5))^2, (x(6)-x(5))^3;
    1, x(7)-x(5), (x(7)-x(5))^2, (x(7)-x(5))^3;
    1, x(8)-x(5), (x(8)-x(5))^2, (x(8)-x(5))^3];
c = A \ y(5:8)';
x_lin = linspace(x(5), x(8));
cube = @(x) c(1) + c(2)*(x - x(5)) + c(3)*(x - x(5)).^2 + + c(4)*(x - x(5)).^3;
hold on;
plot(x_lin, cube(x_lin), 'r')

% cubic poly. with divided differences
x1 = x(5); x2 = x(6); x3 = x(7); x4 = x(8);
f1 = y(5); f2 = y(6); f3 = y(7); f4 = y(8);
f12 = (f2 - f1) / (x2 - x1); f23 = (f3 - f2) / (x3 - x2); f34 = (f4 - f3) / (x4 - x3);
f123 = (f23 - f12) / (x3 - x1); f234 = (f34 - f23) / (x4 - x2);
f1234 = (f234 - f123) / (x4 - x1);

x = linspace(x1, x4);
P = @(x) f1 + f12.*(x-x1) + f123.*(x-x1).*(x-x2) + f1234.*(x-x1).*(x-x2).*(x-x3);
hold on; plot(x, P(x), 'g')
P_p = @(x) f12 + f123 .* ((x - x2) + (x - x1)) + f1234 .* ((x - x2).*(x - x3) + (x - x1).*(x - x3) + (x - x1).*(x - x2));
P_p(x1)
line = @(x) f1 + P_p(x1).*(x-x1);
hold on; plot(linspace(24, 25), line(linspace(24, 25)), 'b')

% Lagrange interpolation
%x = [12.8, 17.6, 21.5, 24];
%y = [2.4, .6, 4, 6];
%L = @(x) y(1).*(x - x(2)).*(x - x(3)).*(x - x(4))./((x(1) - x(2)).*(x(1) - x(3)).*(x(1) - x(4))) + ...
%    y(2).*(x - x(1)).*(x - x(3)).*(x - x(4))./((x(2) - x(1)).*(x(2) - x(3)).*(x(2) - x(4))) + ...
%    y(3).*(x - x(1)).*(x - x(2)).*(x - x(4))./((x(3) - x(1)).*(x(3) - x(2)).*(x(3) - x(4))) + ...
%    y(4).*(x - x(1)).*(x - x(2)).*(x - x(3))./((x(4) - x(1)).*(x(4) - x(2)).*(x(4) - x(3)));
%x_lin = linspace(x(1), x(end)); 
%figure(2)
%plot(x,y,'ro'); hold on; %plot(x_lin, L(x_lin)); hold on;
%x_lin = 12.8:.1:24;
%hold on; plot(x, L(x)); hold on;
