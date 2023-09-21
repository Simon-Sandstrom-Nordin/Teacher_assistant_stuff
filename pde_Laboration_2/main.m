clc; clear all; close all;

x0 = 0; xL = 1; h = .001;
x_vec = x0:h:xL; n = (xL - x0) / h;
a_f = @(x) exp(x);
f = @(x) exp(x);
g = 1;
u_f = @(x) integral(@(y) (g + integral(f, y, 1, 'Arrayvalued', true)) ./ a_f(y), 0, x, 'Arrayvalued', true);

% Stiffness matrix
A = zeros(n-1,n-1);
% contributions from the a(x) function
bot = zeros(n-2,1);
for k = 1:n-2
    a = x_vec(k);
    b = x_vec(k+1);
    x1 = -1/sqrt(3);
    x2 = 1/sqrt(3);
    xsi = [x1, x2];

    bot(k) = 0;
    for m = 1:2
        bot(k) = bot(k) + ((b-a)/2) * a_f(((b-a)/2) * xsi(m) + (a + b)/2);
    end

end

mid = zeros(n-1,1);
for k = 1:n-1
    a = x_vec(k);
    b = x_vec(k+1);
    x1 = -1/sqrt(3);
    x2 = 1/sqrt(3);
    xsi = [x1, x2];

    mid(k) = 0;
    for m = 1:2
        mid(k) = mid(k) + ((b-a)/2) * a_f(((b-a)/2) * xsi(m) + (a + b)/2);
    end
end

top = zeros(n-2,1);
for k = 1:n-2
    a = x_vec(k);
    b = x_vec(k+2);
    x1 = -1/sqrt(3);
    x2 = 1/sqrt(3);
    xsi = [x1, x2];

    top(k) = 0;
    for m = 1:2
        top(k) = top(k) + ((b-a)/2) * a_f(((b-a)/2) * xsi(m) + (a + b)/2);
    end
end

% contribution from test functions
A=A+diag((-1).*bot,-1)+diag(2.*mid,0)+diag((-1).*top, 1);
A = (1/h).*A;
A = sparse(A);

% Load vector
L = zeros(n-1,1);
for k = 1:n-1
    a = x_vec(k);
    b = x_vec(k+2);
    x1 = -1/sqrt(3);
    x2 = 1/sqrt(3);
    xsi = [x1, x2];
    hat = @(x) 1 - abs(x - x_vec(k+1));
    psi = @(x) hat(x) * f(x);

    L(k) = 0;
    for m = 1:2
        L(k) = L(k) + ((b-a)/2) * psi(((b-a)/2) * xsi(m) + (a + b)/2);
    end

end

%
u = A \ L;
figure(1)
plot(x_vec, [0, u', 0]), ylim([0,1.5])

figure(2)
x_vec = linspace(0,1);
u_vec = [];
for k = 1:100
    u_vec(end+1) = u_f(x_vec(k));
end
plot(x_vec, u_vec)
