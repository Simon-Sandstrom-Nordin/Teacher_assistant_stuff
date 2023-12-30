clc; clear; close all;

% hmw 1

[A, b, c, beta] = hw1data(001208)

polyplot(A,b,[0, 10], [0, 10])
[x,z,y,r,beta,iter] = simplex(A,b,c,beta)


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

[mu'; ones(1, length(mu))]
r = 3.00;
% equality conditions, x >= 0
X = quadprog(C, zeros(length(mu), 1), [mu'; ones(1, length(mu))], [r, 1]', [], [], zeros(1, length(mu)), [])

% equality then inequality, x >=0
X = quadprog(C, zeros(length(mu), 1), mu', r, ones(1, length(mu)), 1, zeros(1, length(mu)), [])

% inequality then equality, x >=0
X = quadprog(C, zeros(length(mu), 1), ones(1, length(mu)), 1, mu', r, zeros(1, length(mu)), [])

% equality conditions
X = quadprog(C, zeros(length(mu), 1), [mu'; ones(1, length(mu))], [r, 1]', [], [], zeros(1, length(mu)))

% zeros(length(mu), 1), [mu'; ones(1, length(mu))], [r, 1]',