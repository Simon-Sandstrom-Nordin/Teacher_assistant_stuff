% Numerisk integration: rotationssymmetrik lur

% The contour y(x) for a rotationally symmetric receiver 
% (I think "lur" in English is receiver, anyway.)
% is defined by the differential equation

yp = @(x, y) - (1/6 + pi.*sin(pi.*x)./(1.6 - cos(pi.*x)))*y;
y0 = 2.6;

% Volume by rotation:
% V = @(y) pi .* integral(y.^2, [0, L]);
L = 4.00;
% approximate the y(x) values. Then use those to calculate the 
% volume with at least 5 digits. 
% hints: Euler + trapezoid rule good options for methods? Followed
% by Richardson-extrapolation? Whatever that is.
% Use different step lengths. How many correct digits? Why? Give
% your calculated volume with error bounds.

% Now find an L for which V_L = .75*V. Find this new L with
% atleast two correct decimals.
% Efficient method is required. Secant or interpolation...

% c. Draw a 3D model. There are instructions for this in the pdf, 
% but essentially 
% X = x.*ones(size(fi)); Y = f.cos(fi); Z = f*sin(fi);
% And then mesh(X, Y, Z) {net} or surf(X, Y, Z) {full 3D figure}.
