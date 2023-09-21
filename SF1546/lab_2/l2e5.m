% Shooting method
% write de as system of first order de:s
clc; clear all; close;

saught = 1.75
guess = 100;
x = fzero(@solver,guess)    % lutningen? ja.

up = @(x, u) [u(2); (-290.*exp(-(x-3.8/2).^2) - u(2)./7) ./ (2 + x./7)];
guess = x;
T0 = 305;
u0 = [T0, guess];
[t, U] = ode45(up, [0,3.8], u0);
figure(2)
plot(t, U(:,1), 'o')
disp(t + " " + U(:,1))

index = 1;
while true
    if t(index) > saught
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
disp(line(saught))

% Built-in splines
figure(3)
xx = 0:.01:3.8;
yy = spline(t, U(:,1), xx);
hold on
plot(t, U(:,1), 'o', xx,yy)


% finding index
for k = 1:length(xx)
    if xx(k) >= saught
        break
    end
end
disp(xx(k))
disp(yy(k))

function F = solver(guess)
up = @(x, u) [u(2); (-290.*exp(-(x-3.8/2).^2) - u(2)./7) ./ (2 + x./7)];
%guess = 200;
T0 = 305;
u0 = [T0, guess];
[t, U] = ode45(up, [0,3.8], u0);
figure(1)
plot(t, U(:,1))
v = U(:,1);
F = v(end) - 455;
end

% 5.118744657121776e+02