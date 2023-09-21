function [new_x,new_xp,new_y,new_yp,new_v] = System_RK4_B(x,xp,y,yp,v,h)
% constants
m = 50*.001;
K = .0005;
g = 9.82;

k1 = xp;
k2 = xp + h*k1/2;
k3 = xp + h*k2/2;
k4 = xp + h*k3;
new_x = x + (h/6)*(k1 + 2*k2 + 2*k3 + k4);
k1 = -(K/m)*xp*v^(3/2);
k2 = -(K/m)*(xp + h*k1/2) *v^(3/2);
k3 = -(K/m)*(xp + h*k2/2) *v^(3/2);
k4 = -(K/m)*(xp + h*k3) *v^(3/2);
new_xp = xp + (h/6)*(k1 + 2*k2 + 2*k3 + k4);
k1 = yp;
k2 = yp + h*k1/2;
k3 = yp + h*k2/2;
k4 = yp + h*k3;
new_y = y + (h/6)*(k1 + 2*k2 + 2*k3 + k4);
k1 = (-g - (K/m)*yp*v^(3/2));
k2 = (-g - (K/m)*(yp + h*k1/2)*v^(3/2));
k3 = (-g - (K/m)*(yp + h*k2/2)*v^(3/2));
k4 = (-g - (K/m)*(yp + h*k3)*v^(3/2));
new_yp = yp + (h/6)*(k1 + 2*k2 + 2*k3 + k4);
new_v = sqrt(new_xp^2 + new_yp^2);


% Explicit euler for systems
%new_x = x + h*xp;
%new_xp = xp + h*(-(K/m)*xp*v^(3/2));
%new_y = y + h*yp;
%new_yp = yp + h*(-g - (K/m)*yp*v^(3/2));
%new_v = sqrt(new_xp^2 + new_yp^2);

end
