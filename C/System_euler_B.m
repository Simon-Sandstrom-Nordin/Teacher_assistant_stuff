function [new_x,new_xp,new_y,new_yp,new_v] = System_euler_B(x,xp,y,yp,v,h)
% constants
m = 50*.01;
K = .0005;
g = 9.82;

% Explicit euler for systems
new_x = x + h*xp;
new_xp = xp + h*(-(K/m)*xp*v^(3/2));
new_y = y + h*yp;
new_yp = yp + h*(-g - (K/m)*yp*v^(3/2));
new_v = sqrt(new_xp^2 + new_yp^2);
end
