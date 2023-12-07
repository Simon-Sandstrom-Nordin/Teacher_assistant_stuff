clc; clear; close all;

M = 1000; % # of points sampled
m = 200;    % dimension of grid

% Meshgrid
x1_omega = linspace(0,1, m); x2_omega = linspace(0,1, m);
[xx1, xx2] = meshgrid(x1_omega, x2_omega);

xp_matrix = rand(2, M)'; % first column holds x1 coordinates, second contains x2's.
f_vector = zeros(M, 1);
for f = 1:M
    if sqrt((xp_matrix(f, 1) - 0.5).^2 + (xp_matrix(f, 2) - 0.5).^2) < 0.1
        f_vector(f) = 1;
    else
        f_vector(f) = 0;
    end
end

v_matrix = zeros(M,2);
v_matrix(:,1) = xp_matrix(:,2);
v_matrix(:,2) = 1 - xp_matrix(:,1);

% fourier series stuff
kappa = 2*pi;   % 
N = 8;  % # of coefficents.
        % so 2N + 1 coefficients.

% v1
v1 = v_matrix(:,1);
A = zeros(M, (2*N + 1)^2);  % adjacent matrix

% loading adjacent matrix
for m_index = 1:M
    for n1 = -N:N
         for n2 = -N:N
             % xp_matrix(m,1) is xp, xp_matrix(m,2) is yp
             A(m_index, (n1 + N) + (n2+N)*(2*N + 1) + 1) = ...
                 exp(1j*kappa*(n1*xp_matrix(m_index,1) ...
                 + n2*xp_matrix(m_index,2)));
        end
    end
end

coefficients = A \ v1;

% creating fourier series
v1_approx_matrix = zeros(m, m);
for x1 = 1:m
    for x2 = 1:m
        for n1 = -N:N
            for n2 = -N:N
                v1_approx_matrix(x1, x2) = v1_approx_matrix(x1, x2) + ...
                    coefficients((n1 + N) + (n2+N)*(2*N + 1) + 1) .* ...
                    exp(1j.*kappa.*(n1.*x1 + n2.*x2)./m);
            end
        end
    end
end

figure(1)
% test it
mesh(xx2, xx1, real(v1_approx_matrix))
title("V1 fourier approximation")
xlabel("x1"); ylabel("x1");

% compare with expected
figure(2)
v1 = @(x,y) y;
mesh(xx1,xx2,real(v1(xx1, xx2)))
title("V1 true values")
xlabel("x1"); ylabel("x1");
% all is fine except I need to mirror the plane accross the y = .5 plane

% v2
v2 = v_matrix(:,2);
A = zeros(M, (2*N + 1)^2);  % adjacent matrix

% loading adjacent matrix
for m_index = 1:M
    for n1 = -N:N
         for n2 = -N:N
             % xp_matrix(m,1) is xp, xp_matrix(m,2) is yp
             A(m_index, (n1 + N) + (n2+N)*(2*N + 1) + 1) = ...
                 exp(1j*kappa*(n1*xp_matrix(m_index,1) + ...
                 n2*xp_matrix(m_index,2)));
        end
    end
end

coefficients = A \ v2;

% creating fourier series
v2_approx_matrix = zeros(m, m);
for x1 = 1:m
    for x2 = 1:m
        for n1 = -N:N
            for n2 = -N:N
                v2_approx_matrix(x1, x2) = v2_approx_matrix(x1, x2) + ...
                    coefficients((n1 + N) + (n2+N)*(2*N + 1) + 1) .* ...
                    exp(1j.*kappa.*(n1.*x1 + n2.*x2)./m);
            end
        end
    end
end

figure(3)
% test it
mesh(xx2, xx1, real(v2_approx_matrix))
title("V2 fourier approximation")
xlabel("x1"); ylabel("x2");

% compare with expected
figure(4)
v2 = @(x,y) 1- x;
mesh(x1_omega,x2_omega,real(v2(xx1, xx2)))
title("V2 true values")
xlabel("x1"); ylabel("x2");
% for some reason, changing the inputs 1 and 2 of the mesh function
% fixes the mirroring problem... Perhaps it has to do with mesh and
% meshgrid.

% f
f = f_vector;
A = zeros(M, (2*N + 1)^2);
% loading adjacent matrix
for m_index = 1:M
    for n1 = -N:N
         for n2 = -N:N
             % xp_matrix(m,1) is xp, xp_matrix(m,2) is yp
             A(m_index, (n1 + N) + (n2+N)*(2*N + 1) + 1) = ...
                 exp(1j*kappa*(n1*xp_matrix(m_index,1) + ...
                 n2*xp_matrix(m_index,2)));
        end
    end
end

coefficients = A \ f;

% creating fourier series
f_approx_matrix = zeros(m, m);
for x1 = 1:m
    for x2 = 1:m
        for n1 = -N:N
            for n2 = -N:N
                f_approx_matrix(x1, x2) = f_approx_matrix(x1, x2) + ...
                    coefficients((n1 + N) + (n2+N)*(2*N + 1) + 1) .* ...
                    exp(1j.*kappa.*(n1.*x1 + n2.*x2)./m);
            end
        end
    end
end

figure(5)
% test it
mesh(xx2, xx1, real(f_approx_matrix))
title("f fourier approximation")
xlabel("x1"); ylabel("x2");

% compare with expected
figure(6)
syms f_approx_f(x1, x2);
f_approx_f(x1, x2) = piecewise(sqrt((x1-.5)^2 + (x2-.5)^2) < .1, 1, ...
    sqrt((x1-.5)^2 + (x2-.5)^2) >= .1,0);
mesh(xx2,xx1,real(f_approx_f(xx1, xx2)))
title("f true values")
xlabel("x1"); ylabel("x2");


% numeric characteristics
K = 10;
x1_v = 1/K: 1/K: 1;
x2_v = 1/K: 1/K: 1;

% grid
u_grid = zeros(m/10,m/10);
% grid scale counter
u_grid_scale_counter = zeros(m/10,m/10);

figure(7)
for k1 = 1:length(x1_v)
    for k2 = 1:length(x2_v)
        x_matrix = [x1_v(k1), x2_v(k2)]; h = .002; u_list = [0];
        iter = 0; maxiter = 1e+9;
        while (x_matrix(end,1)<1)&&(x_matrix(end,2)<1)
            x1 = x_matrix(end,1);
            x2 = x_matrix(end,2);
            x1_coordinate = int32(x1*m);
            x2_coordinate = int32(x2*m);
            [x1, x2, u] = Euler_func(x_matrix(end,1), x_matrix(end,2), ...
                u_list(end), h, ...
                v1_approx_matrix(x1_coordinate, x2_coordinate), ...
                v2_approx_matrix(x1_coordinate, x2_coordinate), ...
                f_approx_matrix(x1_coordinate, x2_coordinate));

            u_list(end+1) = u;
            x_matrix(end+1,:) = [x1, x2];
        
            if iter > maxiter
                disp("max iter hit")
                break
            end
            iter = iter + 1;
        end
        % lower/ raise to match boundry conds.
        % u_list = u_list - u_list(end);
        hold on;
        plot3(x_matrix(:,1), x_matrix(:,2), real(u_list'), 'bo')
        title("Characteristic curves started in a grid, h = 0.002, euler forwards");
        xlabel("x1"); ylabel("x2");

        for index = 1:length(u_list)
            x1 = x_matrix(index,1);
            x2 = x_matrix(index,2);
            x1_coordinate = int32(x1*m/10);
            x2_coordinate = int32(x2*m/10);
            u_grid(x1_coordinate, x2_coordinate) = ...
                u_grid(x1_coordinate, x2_coordinate) + u_list(index);
            u_grid_scale_counter(x1_coordinate, x2_coordinate) = ...
                u_grid_scale_counter(x1_coordinate, x2_coordinate) + 1;
        end 
    hold on;
    end
end

figure(8)
% New meshgrid
x1_omega = linspace(0,1, m/10); x2_omega = linspace(0,1, m/10);
[xx1, xx2] = meshgrid(x1_omega, x2_omega);

% scale down
for x1 = 1:m/10
    for x2 = 1:m/10
        if u_grid_scale_counter(x1,x2) ~= 0
            u_grid(x1,x2) = u_grid(x1,x2) / u_grid_scale_counter(x1,x2);
        end
    end
end

figure(9)
% New meshgrid
x1_omega = linspace(0,1, m/10); x2_omega = linspace(0,1, m/10);
[xx1, xx2] = meshgrid(x1_omega, x2_omega);

mesh(xx2,xx1,real(u_grid));
title("Meshed surface from grid characteristics, h = .002");
xlabel("x1"); ylabel("x2");

% Plotting level curves
figure(10);
[meshX, meshY] = meshgrid(linspace(0, 1, size(u_grid, 2)), linspace(0, 1, size(u_grid, 1)));
contour(meshX, meshY, real(u_grid));
title('Level Curves of u');
xlabel('x1');
ylabel('x2');
colorbar; % Add a color bar to show the contour levels

function [x1_n, x2_n, u] = Euler_func(x1, x2, u, h, v1, v2, f)
u = euler(u,f,h);
x1_n = euler(x1,v1, h);
x2_n = euler(x2,v2, h);
end

function [new] = euler(old, d, h)
new = old + d*h;
end
