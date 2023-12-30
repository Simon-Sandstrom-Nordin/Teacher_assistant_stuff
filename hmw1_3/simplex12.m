%SIMPLEX12 Crudex simplex code for solving an LP problem including phase I
%          [x,z,y,r,beta,iter1,iter2] = simplex12(A,b,c)
%          solves the problem 
%                        minimize     c'x
%                        subject to   A x = b
%                                     x >= 0
%        
%          On successful termination, x contains the optimal solution, and
%          z contains the final objective function value. Y contains
%          an optimal dual solution and r contains the dual slacks. Beta
%          contains the final basis and iter1 and iter2 denotes the number
%          of iterations in phase I and phase 2.

%        Crude version, written by Anders Forsgren for use in SF1811 Optimization

function [x,z,y,r,basis,iter1,iter2] = simplex12(A,b,c)

[m,n] = size(A);
fuzz = sqrt(eps);

A1 = [ A diag(sign(b+fuzz)) ];
c1 = [ zeros(n,1) ; ones(m,1) ];
basis = n+1:n+m;

[xfeas,suminf,y,r,basis,iter1] = simplex(A1,b,c1,basis);

if suminf > fuzz
  x=[]; z=[]; y=[]; r=[]; beta=[]; iter2=[];
  fprintf('Error, no feasible solution exists \n\n')
else
  if max(basis) > n
    fprintf('Warning, artificial variables are still basic \n')
    fprintf('Cannot be dealt with properly in this implementation \n\n')
    basart = basis(find(basis>n));
    basis  = [ basis(find(basis<=n)) n+1:n+length(basart) ];
    [x,z,y,r,basis,iter2] = ...
    simplex(A1(:,[1:n basart]),b,[c;1e6*ones(size(basart'))],basis);
    x = x(1:n);
    r = r(1:n);
  else
    [x,z,y,r,basis,iter2] = simplex(A,b,c,basis);
  end
end
