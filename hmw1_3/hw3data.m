%%% hw3data.m %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Problem data for homework assignment 3, SF1811, 2023/2024
% Creates C and mu

rng(YYMMDD)  % ReplaceYYMMDD by one member's date of birth

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
