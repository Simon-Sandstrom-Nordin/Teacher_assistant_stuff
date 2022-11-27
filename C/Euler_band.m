function [new_z, new_zp] = Euler_band(z, zp, h)
% constants
m = 50*.001;    % kg
L0 = 10*.01;    % m
B = 12*.01;     % m
k = 950;        % N/m

% calulate length
L = 2*sqrt(z^2 + (B/2)^2); 

% Euler forwards
new_z = z - h*zp;
new_zp = zp + h*(k/m)*(L - L0);
end
