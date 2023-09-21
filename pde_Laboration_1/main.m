clc; clear; close all;

%% Assignment 1
% None
%% Assignment 2
clc; clear all; close all;

M = 5000;   % # of points

omega = zeros(M, M);    % All possible points

xp_matrix = rand(2, M)';    % first column holds x1 coordinates,
                            % second contains x2:s.
f_vector = zeros(1,M)';
for k = 1:M
    if sqrt(((xp_matrix(k,1) - .5)^2 + (xp_matrix(k,2) - .5)^2)) < .1
        f_vector(k) = 1;
    else
        f_vector(k) = 0;
    end
end
v_matrix = zeros(M,2);
for k = 1:M
    % !!!!!!!!!!!!!!!!!!!!!! Doesn't make sense but the fix works
    % wonderfully.
    v_matrix(k,1) = 1 - xp_matrix(k,2);
    v_matrix(k,2) = xp_matrix(k,1);
end

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
v1_approx_f = @(x1, x2) 0;
for n1 = -N:N
    for n2 = -N:N
        % xp_matrix(m,1) is xp, xp_matrix(m,2) is yp
        term = @(x1, x2) coefficients((n1 + N)*(2*N + 1) + (n2+N) + 1) .* exp(1j.*kappa.*(n1.*x1 + n2.*x2));
        v1_approx_f = @(x1, x2) v1_approx_f(x1, x2) + term(x1, x2);
    end
end

figure(1)
% test it
x1 = linspace(0,1); x2 = linspace(0,1);
[xx1, xx2] = meshgrid(x1, x2);
mesh(xx1, xx2, real(v1_approx_f(xx1,xx2)))

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
v2_approx_f = @(x1, x2) 0;
for n1 = -N:N
    for n2 = -N:N
        % xp_matrix(m,1) is xp, xp_matrix(m,2) is yp
        term = @(x1, x2) coefficients((n1 + N)*(2*N + 1) + (n2+N) + 1) .* exp(1j.*kappa.*(n1.*x1 + n2.*x2));
        v2_approx_f = @(x1, x2) v2_approx_f(x1, x2) + term(x1, x2);
    end
end

figure(3)
% test it
x1 = linspace(0,1); x2 = linspace(0,1);
[xx1, xx2] = meshgrid(x1, x2);
mesh(xx1, xx2, real(v2_approx_f(xx1,xx2)))

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
for n1 = -N:N
    for n2 = -N:N
        % xp_matrix(m,1) is xp, xp_matrix(m,2) is yp
        term = @(x1, x2) coefficients((n1 + N)*(2*N + 1) + (n2+N) + 1) .* exp(1j.*kappa.*(n1.*x1 + n2.*x2));
        f_approx_f = @(x1, x2) f_approx_f(x1, x2) + term(x1, x2);
    end
end

figure(5)
% test it
x1 = linspace(0,1); x2 = linspace(0,1);
[xx1, xx2] = meshgrid(x1, x2);
mesh(xx1, xx2, real(f_approx_f(xx1,xx2)))

% compare with expected
%figure(6)
%mesh(xx1,xx2,real(f_actual(xx1,xx2)))

%v_function = @(x1, x2) [v1_approx_f(x1, x2); v2_approx_f(x1, x2)];

% %%%
% numeric characteristics
K = 10;
x1_v = 1/K: 1/K: 1;
x2_v = 1/K: 1/K: 1;

figure(6)
for k1 = 1:length(x1_v)
    for k2 = 1:length(x2_v)
        x_matrix = [x1_v(k1), x2_v(k2)]; h = .001; u_list = [0];
        iter = 0; maxiter = 1e+9;
        while (x_matrix(end,1)>0)&&(x_matrix(end,2)>0)
            [x1, x2, u] = RK4(x_matrix(end,1), x_matrix(end,2), u_list(end), h, v1_approx_f, v2_approx_f, f_approx_f);
            u_list(end+1) = u;
            x_matrix(end+1,:) = [x1, x2];
        
            if iter > maxiter
                disp("max iter hit")
                break
            end
            iter = iter + 1;
        end
        % lower/ raise to match boundry conds.
        u_list = u_list - u_list(end);
        hold on;
        plot3(x_matrix(:,1), x_matrix(:,2), u_list', 'bo')

%         % reset and halv step-length
%         x_matrix = [x1_v(k1), x2_v(k2)]; h = h/2; u_list = [0];
%         iter = 0; maxiter = 1e+9;
%         while (x_matrix(end,1)>0)&&(x_matrix(end,2)>0)
%             [x1, x2, u] = RK4(x_matrix(end,1), x_matrix(end,2), u_list(end), h, v1_approx_f, v2_approx_f, f_approx_f);
%             u_list(end+1) = u;
%             x_matrix(end+1,:) = [x1, x2];
%         
%             if iter > maxiter
%                 disp("max iter hit")
%                 break
%             end
%             iter = iter + 1;
%         end
%         % lower/ raise to match boundry conds.
%         if u_list(end) < 0
%             u_list = u_list - u_list(end);
%         else
%             u_list = u_list + u_list(end);
%         end
% 
%         hold on
%         plot3(x_matrix(:,1), x_matrix(:,2), u_list', 'ro')
% 
%         disp("test")
    end
end

function [x1_n, x2_n, u] = RK4(x1,x2,u,h, v1_approx_f, v2_approx_f, f_approx_f)
u = rk4(u,x1,x2,f_approx_f, h, -1);
x1_n = rk4(x1,x1,x2,v1_approx_f, h, -1);
x2_n = rk4(x2,x1,x2,v2_approx_f, h, -1);
end

function [new] = rk4(old,x1,x2,f, h, sign)
k_1 = f(x1,x2);
k_2 = f(x1+0.5*h,x2+0.5*h*k_1);
k_3 = f((x1+0.5*h),(x2+0.5*h*k_2));
k_4 = f((x1+h),(2+k_3*h));
new = old + sign*(1/6)*(k_1+2*k_2+2*k_3+k_4)*h;
end

function out = f_actual(x1,x2)  %put this in mfile
if  sqrt((x1 - .5)^2 + (x2 - .5)^2) < .1
    out = 1;
else
    out = 0;
end
end


%% Assignment 3
% ...
%% Assignment 4

%% Comment blocks

%v1_approx_f = @(x1, x2) 0;  % to be built upon with fourier terms
% for m = 1:M
%     % finding the coefficient terms
%     % loading wind vector
%     wind = ones(1, (2*N + 1)^2)';
%     for w = 1:(2*N + 1)^2
%         wind(w) = v_matrix(m,1);
%     end
%     % loading adjacent matrix
%     A = zeros(2,(2*N + 1)^2)';
%     for n1 = -N:N
%         for n2 = -N:N
%             % xp_matrix(m,1) is xp, xp_matrix(m,2) is yp
%             A((n1 + N)*(2*N + 1) + (n2+N) + 1, 1) = exp(1j*kappa*(n1*xp_matrix(m,1)));
%             A((n1 + N)*(2*N + 1) + (n2+N) + 1, 2) = exp(1j*kappa*(n2*xp_matrix(m,2)));
%         end
%     end
%     % solving in least square sense for the coefficients
%     coefficients = A \ wind;
%     % creating fourier series term
%     for n1 = -N:N
%         for n2 = -N:N
%             term = @(x1, x2) coefficients((n1 + N)*(2*N + 1) + (n2+N) + 1) *exp(1j*kappa*(n1*x1 + n2*x2));
%             term(.5,.5)
%             v1_approx_f = @(x1, x2) v1_approx_f(x1, x2) + term(x1, x2);
%             v1_approx_f(.5,.5)
%         end
%     end
% end
% 
% 
% % creating fourier series
% v2_approx_f = @(x1, x2) 0;
% for n1 = -N:N
%     for n2 = -N:N
%         % xp_matrix(m,1) is xp, xp_matrix(m,2) is yp
%         term = @(x1, x2) exp(1j*kappa*(n1*xp_matrix(m,1) + n2*xp_matrix(m,2)));
%         v2_approx_f = @(x1, x2) v2_approx_f(x1, x2) + term(x1, x2);
%     end
% end
% 
% for m = 1:M
%     f_approx = 0;
%     for n1 = -N:N
%         for n2 = -N:N
%             % xp_matrix(m,1) is xp, xp_matrix(m,2) is yp
%             term = exp(1j*kappa*(n1*xp_matrix(m,1) + n2*xp_matrix(m,2)));
%             f_approx = f_approx + term;
%         end
%     end
%     difference_squared = (f_vector(m) - f_approx)^2;
% end
% % creating fourier series
% f_approx_f = @(x1, x2) 0;
% for n1 = -N:N
%     for n2 = -N:N
%         % xp_matrix(m,1) is xp, xp_matrix(m,2) is yp
%         term = @(x1, x2) exp(1j*kappa*(n1*xp_matrix(m,1) + n2*xp_matrix(m,2)));
%         f_approx_f = @(x1, x2) f_approx_f(x1, x2) + term(x1, x2);
%     end
% end
