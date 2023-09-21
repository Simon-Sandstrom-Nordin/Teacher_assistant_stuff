clc; clear; close all;

% note to self: GPT gives options I don't understand,
% like flattening a matrix

M = 1000;   % # of points

omega = zeros(M, M);    % All possible points

x_matrix = rand(2, M)';    % first column holds x1 coordinates,
                            % second contains x2:s.
f_vector = zeros(1, M);
f_vector(sqrt((x_matrix(:, 1) - 0.5).^2 + (x_matrix(:, 2) - 0.5).^2) < 0.1) = 1;
v_matrix = zeros(M,2);
v_matrix(:,1) = 1 - x_matrix(:,2);
v_matrix(:,2) = x_matrix(:,1);

% fourier series stuff
kappa = 2*pi;   % 
N = 4; % # of coefficents.
        % so 2N + 1 coefficients.

% v1
v1 = v_matrix(:,1);

% create matrix of exponentials
[x1_grid, x2_grid, n1_grid, n2_grid] = ndgrid(x_matrix(:,1), x_matrix(:,2), -N:N, -N:N);
exp_matrix = exp(1j * kappa * (n1_grid .* x1_grid + n2_grid .* x2_grid));

% flatten the last two dimensions of exp_matrix
exp_matrix = reshape(exp_matrix, [], size(exp_matrix, 3) * size(exp_matrix, 4));

% compute coefficients
coefficients = exp_matrix' \ v1;

% creating fourier series
v1_approx_f = @(x1, x2) reshape(exp_matrix * coefficients, size(x1));


figure(1)
% test it
x1 = linspace(0,1); x2 = linspace(0,1);
[xx1, xx2] = meshgrid(x1, x2);
mesh(xx1, xx2, real(v1_approx_f(xx1,xx2)))