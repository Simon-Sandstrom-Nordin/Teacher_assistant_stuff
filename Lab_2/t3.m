% Shooting method
% write de as system of first order de:s
clc; clear all; close;

guess = 100;
x = fzero(@solver,guess)    % lutningen? ja.

up = @(x, u) [u(2); (-280.*exp(-(x-3.6/2).^2) - u(2)./3) ./ (2 + x./3)];
guess = x;
T0 = 315;
u0 = [T0, guess];
[t, U] = ode45(up, [0,3.6], u0);
figure(2)
plot(t, U(:,1), 'o')
disp(t + " " + U(:,1))

index = 1;
while true
    if t(index) > 1.65
        break
    end
    index = index + 1;
end
Temp = U(:,1);
disp(t(index - 1) + " " + Temp(index - 1))
disp(t(index) + " " + Temp(index))
line = @(x) Temp(index) + ( (Temp(index)-Temp(index-1))/(t(index) - t(index - 1)) ).* (x - t(index)) ;
test_t = linspace(t(index) - .5, t(index) + .5);
hold on
plot(test_t, line(test_t))
disp(line(1.65))
% intervallhalvering
% x_low = t(index-1); x_high = t(index);
% error = 1;
% while error > .00001
%     x_mid = (x_high + x_low)/2;
% 
%     low = line(x_low);
%     mid = line(x_mid);
%     high = line(x_high);
% 
%     if high*mid < 0
%         x_low = x_mid;
%     else
%         x_high = x_mid;
%     end
%     error = x_high - x_low;
% end
% disp(line(x_mid))

% Built-in splines
figure(3)
xx = 0:.01:4;
yy = spline(t, U(:,1), xx);
hold on
plot(t, U(:,1), 'o', xx,yy)

% linear interpolation and interval halvation?
% ... or try something more advanced.
% or nvm, we have the point given somewhere in yy

% finding index
for k = 1:length(xx)
    if xx(k) > 1.65
        break
    end
end
disp(xx(k))
disp(yy(k))

function F = solver(guess)
up = @(x, u) [u(2); (-280.*exp(-(x-3.6/2).^2) - u(2)./3) ./ (2 + x./3)];
%guess = 200;
T0 = 315;
u0 = [T0, guess];
[t, U] = ode45(up, [0,3.6], u0);
figure(1)
plot(t, U(:,1))
v = U(:,1);
F = v(end) - 445;
end

% 5.118744657121776e+02