clc; clear all; close all;

% no. elements
n = 1000;

x0 = 0; xL = 1;  h = (xL - x0) / (n+1);
x_vec = x0:h:xL;
a_f = @(x) exp(x);
f = @(x) exp(x);
g = 1;
u_f = @(x) integral(@(y) (g + integral(f, y, 1, 'Arrayvalued', true)) ./ a_f(y), 0, x, 'Arrayvalued', true);

% Stiffness matrix
A = zeros(n,n);
% contributions from the a(x) function
bot = zeros(n-1,1);
for k = 1:n-1
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

mid = zeros(n,1);
for k = 1:n
    a = x_vec(k);
    b = x_vec(k+2);
    x1 = -1/sqrt(3);
    x2 = 1/sqrt(3);
    xsi = [x1, x2];

    mid(k) = 0;
    for m = 1:2
        mid(k) = mid(k) + ((b-a)/2) * a_f(((b-a)/2) * xsi(m) + (a + b)/2);
    end
end

top = zeros(n-1,1);
for k = 1:n-1
    a = x_vec(k+2);
    b = x_vec(k+3);
    x1 = -1/sqrt(3);
    x2 = 1/sqrt(3);
    xsi = [x1, x2];

    top(k) = 0;
    for m = 1:2
        top(k) = top(k) + ((b-a)/2) * a_f(((b-a)/2) * xsi(m) + (a + b)/2);
    end
end

% contribution from test functions
A=A+diag((-1).*bot,-1)+diag(mid,0)+diag((-1).*top, 1);
A = (1/(h^2)).*A;
A = sparse(A);

% Load vector
L = zeros(n,1);
for k = 1:n
    a = x_vec(k);
    b = x_vec(k+2);
    x1 = -1/sqrt(3);
    x2 = 1/sqrt(3);
    xsi = [x1, x2];
    hat = @(x) 1 - abs(x - x_vec(k));
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
x_evec = linspace(0,1);
u_vec = [];
for k = 1:100
    u_vec(end+1) = u_f(x_evec(k));
end
plot(x_evec, u_vec)
