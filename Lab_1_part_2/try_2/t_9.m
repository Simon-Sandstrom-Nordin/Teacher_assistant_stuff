clc; clear; close all;

yp = @(x,y) - (1/6 + (pi.*sin(pi.*x)) ./ (1.6 - cos(pi.*x))).*y;
y_0 = 2.6;

L = 4;
[t, y] = ode45(yp, [0, L], y_0);
figure(1)
plot(t,y)

v = @(y) pi .* y.^2;
V = v(y);
Volume = trapz(V)

L_linspace = linspace(1, 4, 1000);
V_linspace = [];    % for now

counter = 1;    % array indexing starts at one.
while length(V_linspace) < length(L_linspace)
    [t, y] = ode45(yp, [0, L_linspace(counter)], y_0);
    V = v(y);
    V_linspace(end+1) = trapz(V);
    counter = counter + 1;
end

figure(2)
plot(L_linspace, V_linspace, 'b-')
hold on
plot(L_linspace, yline(Volume*.75))
