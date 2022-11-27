function [new_x,new_xp,new_y,new_yp,new_v] = System_euler_A(x,xp,y,yp,v,h)
% constants
m = 26*.01;
Kx = .001;
Ky = .01;
g = 9.82;

% Explicit euler for systems
new_x = x + h*xp;
new_xp = xp + h*(-(Kx/m)*xp*v);
new_y = y + h*yp;
new_yp = yp + h*(-g - (Ky/m)*yp*v);
new_v = sqrt(new_xp^2 + new_yp^2);
end
