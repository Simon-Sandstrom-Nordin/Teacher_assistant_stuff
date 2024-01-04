function [x,z,y,r,beta,iter] = simplex(A,b,c,beta)

[m,n] = size(A);
iter = 0;
rnymin = -1;
fuzz = sqrt(eps);

r = zeros(n, 1);        
ny = [1:n];
ny(beta) = [];

Abeta = A(:,beta);
bbar = Abeta\b;

x(beta,1) = bbar;
x(ny,1) = zeros(length(ny),1);

% Display initial x, y, and r
y = (Abeta')\c(beta);
r(ny,1) = c(ny) - A(:,ny)'*y;
disp('Initial Values:');
disp('---------------');
fprintf('Initial x:\n');
disp(x');
fprintf('Initial y:\n');
disp(y');
fprintf('Initial r:\n');
disp(r');

while rnymin < -fuzz
  fprintf('\nIter: %d\n', iter);
  fprintf('----------------------\n');

  Abeta = A(:,beta);
  Any = A(:,ny);

  cbeta = c(beta);
  cny = c(ny);

  y = (Abeta')\cbeta;
  rny = cny-Any'*y;

  zbar = cbeta'*bbar;
  
  if min(bbar) < -fuzz
    keyboard
    fprintf('\nError, basis is not primal feasible\n\n')
    break;
  end

  % Dantzig rule
  [rnymin,q] = min(rny);

  if rnymin < -fuzz
    k = ny(q);
    Abark = Abeta\A(:,k);
    Abarkpos = find(Abark>fuzz);
    if length(Abarkpos) > 0
      [tmax,ppos]= min(bbar(Abarkpos)./Abark(Abarkpos));
      p = Abarkpos(ppos);
    else
      fprintf('\nProblem has unbounded solution\n\n')
      break;
    end
    
    bbar = bbar-tmax*Abark;
    bbar(p) = tmax;

    betap = beta(p);
    nyq = ny(q);        
    beta(p) = nyq;
    ny(q) = betap;

    x(beta,1) = bbar;
    x(ny,1) = zeros(length(ny),1);
    r(beta,1) = zeros(length(beta),1);
    r(ny,1) = rny;

    fprintf('z: %f\n', zbar);
    fprintf('x:\n');
    disp(x');
    fprintf('y:\n');
    disp(y');
    fprintf('r:\n');
    disp(r');

    iter = iter + 1;
    
  else
    fprintf('Optimal solution found\n\n');
    x(beta,1) = bbar;
    x(ny,1) = zeros(length(ny),1);
    r(beta,1) = zeros(length(beta),1);
    r(ny,1) = rny;

    fprintf('Final z: %f\n', zbar);
    fprintf('Final x:\n');
    disp(x');
    fprintf('Final y:\n');
    disp(y');
    fprintf('Final r:\n');
    disp(r');
    break;
  end
end

z = zbar;

end