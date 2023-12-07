% Define the number of elements
N = 20; % For example
L = 1;  % Length of the rod

% Discretization
delta_x = L / N;

% Initialize global matrices
K = zeros(N+1, N+1);
F = zeros(N+1, 1);

% Define the function for thermal conductivity 'a'
a = @(x) 1+x;

% Define the function for the heat source 'f'
f = @(x) 1+x;

% Loop over elements
for i = 1:N
    x_i = (i - 1) * delta_x;
    x_ip1 = i * delta_x;
    
    % Element matrix for the stiffness matrix
    Ke = (1/delta_x) * [a(x_i) + a(x_ip1), -a(x_ip1); -a(x_ip1), a(x_ip1)];
    
    % Element vector for load contribution
    Fe = (delta_x / 6) * [2*delta_x*f(x_i) + delta_x*f(x_ip1); delta_x*f(x_i) + 2*delta_x*f(x_ip1)];
    
    % Assemble local contributions into the global system
    rows = [i, i+1];
    cols = [i, i+1];
    
    K(rows, cols) = K(rows, cols) + Ke;
    F(rows) = F(rows) + Fe;
end

% Apply boundary conditions
% Boundary condition at x = 0 (u(0) = 0)
K(1, :) = 0; K(1, 1) = 1; F(1) = 0;

% Boundary condition at x = 1 (a(1) * u'(1) = g)
% Approximate u'(1) using a backward difference scheme
u_N = U(end); % Temperature at the last node
u_N_1 = U(end - 1); % Temperature at the second-to-last node
u_N_2 = U(end - 2); % Temperature at the third-to-last node

% Approximate u'(1)
u_prime_1 = (3*u_N - 4*u_N_1 + u_N_2) / (2 * delta_x);

g = 3;

% Apply the boundary condition to modify the global matrix and vector
K(end, :) = 0;
K(end, end) = a(1);
F(end) = g - a(1) * u_prime_1;

% Apply boundary condition at x = 0 (u(0) = 0)
% This modifies the global matrix and vector
F(1) = 0;

% Solve the system
U = K \ F;

% Plot the results
x = linspace(0, L, N+1);
plot(x, U);
xlabel('Position along the rod');
ylabel('Temperature');
title('Temperature Distribution along the Rod');
