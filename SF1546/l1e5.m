clc; clear all; close all;

date = 1:13;
hour = [6, 8, 10, 13, 15, 18, 18, 16, 14, 11, 8, 6, 6];
minutes = [15,6,32,15,55,3,24,38,4,24,46,36,14];
time = 60.*hour + minutes;
figure(1); plot(date, time, 'bo')

% A. Interpolationspolynom genom samtliga punkter.

% Lagrange-interpolation:
coefficient_list = ones(13,1);
denominator_list = ones(13,1);
% calculate the coefficients
for coefficient = 1:13  % läsbar kod! Med for-loopens counters namn.
    % ignore (x - x_first) termen. Den tar vi i interpolationsfunktionen.
    % numerator = 1; actually, skip the numerator entierly.
    denominator = 1;
    for month = 1:13
        if month == coefficient
            continue
        end
        denominator = denominator * (date(coefficient) - date(month));
    end
    denominator_list(coefficient) = denominator;
end

% Creating the Lagrange interpolating polynomial function by adding terms.
denom = denominator_list;   % for shorter names.
L_p = @(x) 0;
for k = 1:13
    coefficient = @(x) 1;
    for j = 1:13
        if k == j   % skip the term if it is equal to the x(index) thing.
            continue
        end
        coefficient = @(x) coefficient(x) .* (x - date(j));
    end
    L_p = @(x) L_p(x) + time(k) .* coefficient(x) ./ denom(k);
end
% L_p(months)==time;%interpolationspolynomet överlappar med alla punkter!.
X = linspace(1,13);
figure(2); plot(date, time, 'bo'); hold on; title("Lagrange")
plot(X, L_p(X), 'r-')   % Så vackert .... fast Runges fenomen uppkommer i
                        % ändpunkterna. Det är därför vi har Splines-
                        % approximationer.

% B. Piece-wise linear interpolation.
months = date;
cell_array_of_terms = {};
for data_point = 1:13 - 1   % this is like a question of fence posts and
                            % fences. 13 posts, 12 fence sections.
    % same thing as before, we're adding terms together
    % term = @(x) 0;
    
    % stuff we need for a linear interpolation
    y0 = time(data_point);
    y1 = time(data_point + 1);
    x0 = months(data_point);
    x1 = months(data_point + 1);

    % finding gradient through difference quotient
    gradient = (y1 - y0) / (x1 - x0);   % finite approximation of the
                                        % derivative at (x0, y0)

    term = @(x) gradient .* (x - x0);
    cell_array_of_terms(end + 1) = {term};
end

c_a_o_t = cell_array_of_terms;
% let's glue our piecewise function together! Attempt with "syms" package.
%syms x
%Linear_interpolation = piecewise(months(1) <= x <= months(2), c_a_o_t{1}, ...
%    months(2) < x <= months(3), c_a_o_t{2}, ...
%    months(3) < x <= months(4), c_a_o_t{3}, ...
%    months(4) < x <= months(5), c_a_o_t{4}, ...
%    months(5) < x <= months(6), c_a_o_t{5}, ...
%    months(6) <= x <= months(7), c_a_o_t{6}, ...
%    months(7) <= x <= months(8), c_a_o_t{7}, ...
%    months(8) <= x <= months(9), c_a_o_t{8}, ...
%    months(9) <= x <= months(10), c_a_o_t{9}, ...
%    months(10) <= x <= months(11), c_a_o_t{10}, ...
%    months(11) <= x <= months(12), c_a_o_t{11}, ...
%    months(12) <= x <= months(13), c_a_o_t{12});
% hold on;
% fplot(Linear_interpolation)
% note... this *sort of works, but it becomes a zig-zag near on the x-axis
% since at the end of every x-interval the fuction value drops back to 0.

% Syms package was difficult, or rather it was odd. Let's try gluing
% vectors together instead.

x_vector = [];
y_vector = [];

for point = 1:length(time) - 1  % until the end of time ...
    x_interval = months(point) : .001 : months(point + 1);   % exes.
    y_interval = time(point) + c_a_o_t{point}(x_interval);
    x_vector = [x_vector x_interval];
    y_vector = [y_vector y_interval];
end
figure(3); plot(date, time, 'bo'); hold on; title("Piece-wise linear")
plot(x_vector, y_vector, 'b-');

x_vector;   % for Lagrange
y_vector;   % for Lagrange
% Random notes on cell arrays in general since I'm using them to store
% function handles: if c = {@(x) x @(x x.^2}, then c(1) accesses the first
% element (which is a cell array) {@(x)x} and c{1} accesses the *element*
% of the first array @(x)x.

% C. Splines approximation through every point. Cubic splines? Probably.
% Interesting note: "Linear Spline" is like piece-wise linear
%                   interpolation. Technically a Splines approximation.
% Notes: If a polynomial approximation has matching zeroths, first, and
% second derivatives at the satisfied data points, then the approximation
% is a cubic spline. "A cubic spline S(x) is a set of cubic polnomials" <-.
% There are three coefficients to be calculated for each S(X) = ax^2+bx+c.
% Terminology: "natural" cublic splines have inflection points at the ends.
% s1_pp(x1) = 0 and Sn_minus_1(xn) = 0. End conditions are conditions such
% as these. With these end-conditions, we have gone from having to solve
% 3n - 5 linears in 3n - 3 unknowns, to having m = 3n - 3 equations and
% unknowns.

%What's a diagonally dominant coefficient matrix? Mostly diagonally sparse?

% Looking at the code in Sauer page 172 for inspiration:
% define the deltas n' shit
n = length(months);
v1 = 0; vn = 0; % are these the natural spline conditions?
A = zeros(n,n); % n times n coefficient matrix (not like c-array, but... M)
r = zeros(n,1); % the resulting vector... leading and trailing zeros reman.
dx = []; dy = [];
for k = 1: n - 1
    dx(k) = months(k+1) - months(k); dy(k) = time(k+1) - time(k);
end
% load the matrix
for k = 2:n-1   % they call this "Load the A matrix". Think factorio carts!
    A(k, k-1:k+1) = [dx(k-1), 2*(dx(k-1) + dx(k)), dx(k)];  % k:th row,
                                            % the three columns indicated.
    % load the resulting vector while you're at it.
    r(k) = 3*(dy(k)/dx(k) - dy(k-1)/dx(k-1));
end
% natural spline conditions
A(1,1) = 1; A(n,n) = 1;

coeff = zeros(n,3);
coeff(:,2) = A\r;
for k = 1:n-1   % I wondered why they had three columns: the d's and be b's
    coeff(k,3) = (coeff(k+1, 2) - coeff(k,2)) / (3*dx(k));  % d's
    coeff(k,1) = dy(k) / dx(k) - dx(k) * (2*coeff(k, 2) + coeff(k+1, 2))/3;
    % they use the d's to find the b's. Ignore that completely please.
end
coeff = coeff(1:n-1, 1:3);  % for some reason, they strip the very last line.
x = months; y = time; k = 100; n = length(x); x1 = []; y1 = [];
% k is number of plotted points.
for i = 1:n-1
    xs= linspace(x(i), x(i+1), k + 1);
    dx = xs - x(i);
    ys = coeff(i,3)*dx; % Sauer: evaluate using nested multipl.
    ys = (ys + coeff(i,2)) .* dx;   
    ys = (ys + coeff(i, 1)) .* dx+y(i);
    x1 = [x1; xs(1:k)']; y1 = [y1;ys(1:k)'];
end
hold on;
x1 = [x1; x(end)]; y1 = [y1; y(end)]; 
figure(4); plot(date, time, 'bo'); hold on; title("Spline");
plot(x1, y1, 'm-')

% Ok, so note: I kind of understand how the coefficients are calculated.
% I have not taken the time to meditate over the fact that this for loop
% containing nested multiplication actually produces my intepolating valus.

% D. Ett andragradspolynom endast med data från 1 juni till 1 agusti.
% Detta motsvarar x(6), x(7), x(8).

X =  x(6:8)'; Y = y(6:8)'; A = [X(1)^2,X(1),1;X(2)^2,X(2),1;X(3)^2,X(3),1];
c = A \ Y;
hold on;
T = linspace(x(1), x(end));
figure(5); plot(date, time, 'bo'); hold on; title("Quad June to August");
plot(T, c(1)*T.^2 + c(2)*T + c(3), 'g-')

% There's a complicated MATLAB code provided on p.172 of Sauer's book
% for calculating the spline coefficients. I should go now, but maybe do
% some of the 3.4 excercises to get a feel for spline conditions and stuff.


% E. Same as in D but now with a least squares approximation from April to
% September. x(4:9)
X = x(4:9)'; Y = y(4:9)'; squared_terms = X.^2; linear_terms = X;
constant_terms = ones(length(X), 1);
A = [squared_terms linear_terms constant_terms];
c = A \ Y;
figure(6); plot(date, time, 'bo'); hold on; title("LSQ quad Apr. 2 Sept.");
plot(T, c(1)*T.^2 + c(2)*T + c(3), 'y-')

% F. Same as D and E but now with all data points.

X = x'; Y = y'; squared_terms = X.^2; linear_terms = X;
constant_terms = ones(length(X), 1);
A = [squared_terms linear_terms constant_terms];
c = A \ Y;
hold on;
figure(7); plot(date, time, 'bo'); hold on; title("LSQ quad all points");
plot(T, c(1)*T.^2 + c(2)*T + c(3), 'k-')

% G. c1 + c2*cos(w*x) + c3*sin(w*x), w = 2*pi / 365, through all points.
omega = 2*pi / 365;
sinus_terms = sin(X.*omega); cosine_terms = cos(X.*omega);
constant_terms = ones(length(X), 1);
A = [constant_terms cosine_terms sinus_terms];
c = A \ Y;
figure(8); plot(date, time, 'bo'); hold on; title("Trig. all points");
plot(T, c(1) + c(2)*cos(T.*omega) + c(3)*sin(T.*omega), 'r-')
