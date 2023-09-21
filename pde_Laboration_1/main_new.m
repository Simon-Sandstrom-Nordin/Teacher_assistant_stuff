clc; clear; close all;

M = 10000; % # of points

% dirt
x1 = linspace(0,1); x2 = linspace(0,1);
[xx1, xx2] = meshgrid(x1, x2);

omega = zeros(M, M); % All possible points

xp_matrix = rand(2, M)'; % first column holds x1 coordinates,
% second contains x2:s.
f_vector = zeros(M, 1);
f_vector(sqrt((xp_matrix(:, 1) - 0.5).^2 + (xp_matrix(:, 2) - 0.5).^2) < 0.1) = 1;
v_matrix = zeros(M,2);
v_matrix(:,1) = 1 - xp_matrix(:,2);
v_matrix(:,2) = xp_matrix(:,1);

% fourier series stuff
kappa = 2*pi;   % 
N = 4; % # of coefficents.
        % so 2N + 1 coefficients.

% v1
v1 = v_matrix(:,1);
A = zeros((2*N + 1)^2, M);
% loading adjacent matrix
for m = 1:M
    for n1 = -N:N
         for n2 = -N:N
             % xp_matrix(m,1) is xp, xp_matrix(m,2) is yp
             A((n1 + N)*(2*N + 1) + (n2+N) + 1, m) = exp(1j*kappa*(n1*xp_matrix(m,1) + n2*xp_matrix(m,2)));
             %A((n1 + N)*(2*N + 1) + (n2+N) + 1, m) = exp(1j*kappa*(n2*xp_matrix(m,2)));
        end
    end
end


coefficients = A' \ v1;

% creating fourier series
v1_approx_matrix = zeros(M, M);
for x1 = 1:M
    for x2 = 1:M
        for n1 = -N:N
            for n2 = -N:N
                v1_approx_matrix(x1, x2) = v1_approx_matrix(x1, x2) + ...
                    coefficients((n1 + N)*(2*N + 1) + (n2+N) + 1) .* exp(1j.*kappa.*(n1.*x1 + n2.*x2)./M);
            end
        end
    end
end

figure(1)
% test it
mesh(omega(:,1), omega(:,2), real(v1_approx_matrix))

% compare with expected
figure(2)
v = @(x,y) y;
mesh(xx1,xx2,real(v(xx1,xx2)))
% all is fine except I need to mirror the plane accross the y = .5 plane

% v2
v2 = v_matrix(:,2);
A = zeros((2*N + 1)^2, M);
% loading adjacent matrix
for m = 1:M
    for n1 = -N:N
         for n2 = -N:N
             % xp_matrix(m,1) is xp, xp_matrix(m,2) is yp
             A((n1 + N)*(2*N + 1) + (n2+N) + 1, m) = exp(1j*kappa*(n1*xp_matrix(m,1) + n2*xp_matrix(m,2)));
             %A((n1 + N)*(2*N + 1) + (n2+N) + 1, m) = exp(1j*kappa*(n2*xp_matrix(m,2)));
        end
    end
end

coefficients = A' \ v2;

% creating fourier series
v2_approx_matrix = zeros(M, M);
for x1 = 1:M
    for x2 = 1:M
        for n1 = -N:N
            for n2 = -N:N
                v2_approx_matrix(x1, x2) = v2_approx_matrix(x1, x2) + ...
                    coefficients((n1 + N)*(2*N + 1) + (n2+N) + 1) .* exp(1j.*kappa.*(n1.*x1 + n2.*x2)./M);
            end
        end
    end
end

figure(3)
% test it
mesh(omega(:,1), omega(:,2), real(v2_approx_matrix))

% compare with expected
figure(4)
v = @(x,y) 1 - x;
mesh(xx1,xx2,real(v(xx1,xx2)))

% f
f = f_vector;
A = zeros((2*N + 1)^2, M);
% loading adjacent matrix
for m = 1:M
    for n1 = -N:N
         for n2 = -N:N
             % xp_matrix(m,1) is xp, xp_matrix(m,2) is yp
             A((n1 + N)*(2*N + 1) + (n2+N) + 1, m) = exp(1j*kappa*(n1*xp_matrix(m,1) + n2*xp_matrix(m,2)));
             %A((n1 + N)*(2*N + 1) + (n2+N) + 1, m) = exp(1j*kappa*(n2*xp_matrix(m,2)));
        end
    end
end

coefficients = A' \ f;

% creating fourier series
f_approx_f = @(x1, x2) 0;
f_approx_matrix = zeros(M, M);
for x1 = 1:M
    for x2 = 1:M
        for n1 = -N:N
            for n2 = -N:N
                f_approx_matrix(x1, x2) = f_approx_matrix(x1, x2) + ...
                    coefficients((n1 + N)*(2*N + 1) + (n2+N) + 1) .* exp(1j.*kappa.*(n1.*x1 + n2.*x2)./M);
            end
        end
    end
end

figure(5)
% test it
mesh(omega(:,1), omega(:,2), real(f_approx_matrix))