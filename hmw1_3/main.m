clc; clear; close all;

% hmw 1

%[A, b, c, beta] = hw1data(001208)

%polyplot(A(:,[1,2]),b,[0, 10], [0, 10])
%[x,z,y,r,beta,iter] = simplex(A,b,c,beta)


% hmw 3

%%% hw3data.m %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Problem data for homework assignment 3, SF1811, 2023/2024
% Creates C and mu
rng(001208)  % ReplaceYYMMDD by one member's date of birth
n=8;
Corr=zeros(n,n);
for i=1:n
    for j=1:n
        Corr(i,j)=(-1)^abs(i-j)/(abs(i-j)+1);
    
    end
end
sigma=zeros(n,1);
mu=zeros(n,1);
sigma(1)=2;
mu(1)=3;
for i=1:n-1
    sigma(i+1)=sigma(i)+2*rand;
    mu(i+1)=mu(i)+1;
end
D=diag(sigma);
C2=D*Corr*D;
C=0.5*(C2+C2');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Initialization
r_values = 3.00:0.25:9.00;
num_r = length(r_values);
X = zeros(n, num_r);
U = zeros(num_r, 1);
V = zeros(num_r, 1);
Y = zeros(n, num_r);
A = [mu'; ones(1, n)];  % Equality constraints matrix

for i = 1:num_r

    r = r_values(i);
    b = [r; 1];  % Right-hand side of equality constraints

    [x,~,~,~] = quadprog(C, zeros(n, 1), [], [], A, b, zeros(n, 1));
    X(:, i) = x;

    disp("------debug-------")
    disp(size(A)); % should be 2xn
    disp(size(C)); % should be nxn
    disp(size(x)); % should be nx1
    % Compute dual variables (U, V) using a more stable method
    lambda = A' \ (C * x );

    % Extract U and V
    U(i) = lambda(1);
    V(i) = lambda(2);
end

% Calculate sigma(x) and mu(x)
SigmaX = sqrt(sum((C * X) .* X, 1));
MuX = mu' * X;

% Plotting
plot(SigmaX, MuX, 'o-');
xlabel('\sigma(x)');
ylabel('\mu(x)');


%[mu'; ones(1, length(mu))]
%r = 3.00;
% equality conditions, x >= 0
%X = quadprog(C, zeros(length(mu), 1), [], [], [mu'; ones(1, length(mu))], [r, 1]', zeros(1, length(mu)), [])

% equality then inequality, x >=0
% X = quadprog(C, zeros(length(mu), 1), mu', r, ones(1, length(mu)), 1, zeros(1, length(mu)), [])

% inequality then equality, x >=0
% X = quadprog(C, zeros(length(mu), 1), ones(1, length(mu)), 1, mu', r, zeros(1, length(mu)), [])

% equality conditions
% X = quadprog(C, zeros(length(mu), 1), [mu'; ones(1, length(mu))], [r, 1]', [], [], zeros(1, length(mu)))

% zeros(length(mu), 1), [mu'; ones(1, length(mu))], [r, 1]',