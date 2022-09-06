% 4. Interpolation och linjära minsta kvartmetoden.
clc; clear all; close all;

months = 1:1:13;    % 1:st of January to 31:st of December. 
hours = [6, 8, 10, 13, 15, 18, 18, 16, 14, 11, 8, 6, 6];
minutes = [15, 6, 32, 15, 55, 4, 25, 38, 4, 24, 46, 36, 14];
time_in_minutes = minutes + 60 * hours;

figure(1);
plot(months, time_in_minutes, 'ko'); xlabel("Months"); ylabel("Minutes")
title("Minutes of daylight per day over the course of a year");

% A. Interpolationspolynom genom samtliga punkter.
% ... kommer vara ett polynom av grad length(months) - 1 = 12.
% första alternativet: Lagrangeinterpolation.
%   fördelar: explicit formel, nog enkelt att beräkna koefficienterna
%             med en nestad for-loop. Ja faktiskt... jag skulle kunna
%             ha en lista med täljare (numerator), en med 
%             nämnare (denominator), och sen fusa dem.
%             def: Vular fraction. "Bråk". Fraction. Common fraction.
%   nackdelar: eventuellt bökigt att skriva koden för.
% andra alternativet: Newton's divided differences.
%   fördelar: i teorin lättare att beräkna koefficienterna via
%             rekursiva anrop i en nästlad for-loop, än för
%             Lagrangepolynomets coefficienter. I teorin.
%   nackdelar: se mitt försök i e_04_horrible.m. Det blir... det blir...
%              svårt. Eller åtminstone i mitt huvud.
% tredje alternativet: Sauer har kod för divided differences.
%   fördelar: lätt att snatta, och jag skulle få svar.
%   nackdelar: jag förstår den inte, inte just nu än iallafall.
%
%   Planen: Why not both? Och så kan jag kolla med cheat-coden i boken.
% orelaterat: "Jag gjorde sämsta alternativet:
%              Jag läste Boken. Och tog inga frågor."

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
        denominator = denominator * (months(coefficient) - months(month));
    end
    denominator_list(coefficient) = denominator;
end

% Creating the Lagrange interpolating polynomial function by adding terms.
time = time_in_minutes; denom = denominator_list;   % for shorter names.
L_p = @(x) 0;
for k = 1:13
    coefficient = @(x) 1;
    for j = 1:13
        if k == j   % skip the term if it is equal to the x(index) thing.
            continue
        end
        coefficient = @(x) coefficient(x) .* (x - months(j));
    end
    L_p = @(x) L_p(x) + time(k) .* coefficient(x) ./ denom(k);
end
L_p(months) == time % interpolationspolynomet överlappar med alla punkter!.
X = linspace(1,13);
hold on;
plot(X, L_p(X), 'r-')   % Så vackert .... fast Runges fenomen uppkommer i
                        % ändpunkterna. Det är därför vi har Splines-
                        % approximationer.

% B. Piece-wise linear interpolation.
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
hold on;
plot(x_vector, y_vector, 'b-');
legend("Data points", "Lagrange polynomial interpolation", ...
    "Piece-wise linear interpolation");

x_vector;
y_vector;
% Random notes on cell arrays in general since I'm using them to store
% function handles: if c = {@(x) x @(x x.^2}, then c(1) accesses the first
% element (which is a cell array) {@(x)x} and c{1} accesses the *element*
% of the first array @(x)x.

% C. Splines approximation through every point. Cubic splines? Probably.
% Interesting note: "Linear Spline" is like piece-wise linear
%                   interpolation. Technically a Splines approximation.

% There's a complicated MATLAB code provided on p.172 of Sauer's book
% for calculating the spline coefficients. I should go now, but maybe do
% some of the 3.4 excercises to get a feel for spline conditions and stuff.
