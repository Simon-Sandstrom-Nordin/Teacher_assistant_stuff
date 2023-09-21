function [x_n,y_n,v_n,b_n,m_n,t_n] = System_RK4(x,y,v,b,m,t,h)
% Constants
k = .01;    % air resistance
g = 9.82;   % gravitational constant

% Rocket thrust
if t < 5
    F = 100;
else
    F = 0;
end

% Air resistance
D = k*v^2;

% Mass lost due to explosion
if t >= 5
    m = .075;
end

% to accomidate for exteremely rapid deacceleration at t = 5
%if (5 <= t) && (t < 6)
%    h = h/10000;
%end

% Difficult to increment
v_n = RK4(v, F/m - D/m - g*cos(b), h);
if v <= 10^(-6)
    b_n = RK4(b, 10^(-6), h);
else
    b_n = RK4(b, (g/v)*sin(b), h);
end
x_n = RK4(x, v*sin(b), h);
y_n = RK4(y, v*cos(b), h);

% Easy to increment
if t >= 5
    m_n = m;
else
    m_n = m - .025*h; % 25 grams per second
end
t_n = t + h;

function new = RK4(old, prime, h)
k1 = prime;
k2 = prime + h*k1/2;
k3 = prime + h*k2/2;
k4 = prime + h*k3;
new = old + (h/6)*(k1 + 2*k2 + 2*k3 + k4);
end
end
