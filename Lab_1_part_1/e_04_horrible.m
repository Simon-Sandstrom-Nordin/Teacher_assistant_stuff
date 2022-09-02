% Interpolation och linjära minsta kvardrametoden.
% note: wait, there's a non-linear method of least squares?
clc; clear all; close;


months = 1:13;  % last one is 31:st of december, but close enough.
hour2min = @(hour) hour.*60;
hours = [6, 8, 10, 13, 15, 18, 18, 16, 14, 11, 8, 6, 6];
minutes = [13, 4, 35, 18, 57, 5, 25, 37, 1, 22, 43, 31, 13];

times_in_minutes = hour2min(hours) + minutes;  % since it's difficult
                % plotting time as a mixture of hours and minutes.

plot(months, times_in_minutes, 'ok') % ok here means 'o' -dots, 'k' -black.

% A. Interpolation-polynomial fit. Include all points.
m = months;
t = times_in_minutes;
% first option: Lagrange interpolation.
%P = @(x) m(1)*(x - t(2))*(x - t(3))*(x-t(3)); % ... no, see below:
% ... there are 13 data points, which means thirteen terms and the
% coefficients would require twelve times two multiplications and twelve
% divisions each. That's a bit to rich for my blood. However, note:
% it would have been something like
% p = y1(x - x2)(x - x3) / ((x1 - x2)(x1 - x3)) + ...
%       y2(x - x1)(x - x3) / ((x2 - x1)(x2 - x3)) + ...
%       y3(x - x1)(x - x2) / ((x3 - x1)(x3 - x2)).
% ... but way longer. See what I mean?

% Newton's divided differences.
T = table(months', times_in_minutes');
T.Properties.VariableNames = {'month', 'minutes of daylight'};
disp(T)

% generate Newton's coefficients.
%co = [];
%for j = 1:13
%    co(j) = t(j);
%end

%for a = 2:13
%    for b = 1: 13 + 1 - a
%        co(a) = (co(a+1) - co(a)) / (t(b+a -1) - t(b));
%    end
%end
% .... I don't quite get the iterative formula working...

% manually?
f_xk = zeros(13,1);
for k = 1:13
    f_xk(k) = t(k);
end

f_xk_xk1 = zeros(13 - 1,1);

for k = 1:13 - 1
    f_xk_xk1(k) = (f_xk(k+1) - f_xk(k)) / (t(k+1) - t(k));
end

f_xk_xk1_xk2 = zeros(13 - 2,1);

for k = 1:13 - 2
    f_xk_xk1_xk2(k) = (f_xk_xk1(k+1) - f_xk_xk1(k)) / (t(k+2) - t(k));
end

f_xk_xk1_xk2_xk3 = zeros(13 - 3,1);

for k = 1:13 - 3
    f_xk_xk1_xk2_xk3(k) = (f_xk_xk1_xk2(k+1) - f_xk_xk1_xk2(k)) / (t(k+3) - t(k));
end

f_xk_xk1_xk2_xk3_xk4 = zeros(13 - 4,1);

for k = 1:13 - 4
    f_xk_xk1_xk2_xk3_xk4(k) = (f_xk_xk1_xk2_xk3(k+1) - f_xk_xk1_xk2_xk3(k)) / (t(k+4) - t(k));
end

f_xk_xk1_xk2_xk3_xk4_xk5 = zeros(13 - 5,1);

for k = 1:13 - 5
    f_xk_xk1_xk2_xk3_xk4_xk5(k) = (f_xk_xk1_xk2_xk3_xk4(k+1) - f_xk_xk1_xk2_xk3_xk4(k)) / (t(k+5) - t(k));
end

f_xk_xk1_xk2_xk3_xk4_xk5_xk6 = zeros(13 - 6,1);

for k = 1:13 - 6
    f_xk_xk1_xk2_xk3_xk4_xk5_xk6(k) = (f_xk_xk1_xk2_xk3_xk4_xk5(k+1) - f_xk_xk1_xk2_xk3_xk4_xk5(k)) / (t(k+6) - t(k));
end

f_xk_xk1_xk2_xk3_xk4_xk5_xk6_xk7 = zeros(13 - 7,1);

for k = 1:13 - 7
    f_xk_xk1_xk2_xk3_xk4_xk5_xk6_xk7(k) = (f_xk_xk1_xk2_xk3_xk4_xk5_xk6(k+1) - f_xk_xk1_xk2_xk3_xk4_xk5_xk6(k)) / (t(k+7) - t(k));
end

f_xk_xk1_xk2_xk3_xk4_xk5_xk6_xk7_xk8 = zeros(13 - 8,1);

for k = 1:13 - 8
    f_xk_xk1_xk2_xk3_xk4_xk5_xk6_xk7_xk8(k) = (f_xk_xk1_xk2_xk3_xk4_xk5_xk6_xk7(k+1) - f_xk_xk1_xk2_xk3_xk4_xk5_xk6_xk7(k)) / (t(k+8) - t(k));
end

f_xk_xk1_xk2_xk3_xk4_xk5_xk6_xk7_xk8_xk9 = zeros(13 - 9,1);

for k = 1:13 - 9
    f_xk_xk1_xk2_xk3_xk4_xk5_xk6_xk7_xk8_xk9(k) = (f_xk_xk1_xk2_xk3_xk4_xk5_xk6_xk7_xk8(k+1) - f_xk_xk1_xk2_xk3_xk4_xk5_xk6_xk7_xk8(k)) / (t(k+9) - t(k));
end

f_xk_xk1_xk2_xk3_xk4_xk5_xk6_xk7_xk8_xk9_xk10 = zeros(13 - 10,1);

for k = 1:13 - 10
    f_xk_xk1_xk2_xk3_xk4_xk5_xk6_xk7_xk8_xk9_xk10(k) = (f_xk_xk1_xk2_xk3_xk4_xk5_xk6_xk7_xk8_xk9(k+1) - f_xk_xk1_xk2_xk3_xk4_xk5_xk6_xk7_xk8_xk9(k)) / (t(k+10) - t(k));
end

f_xk_xk1_xk2_xk3_xk4_xk5_xk6_xk7_xk8_xk9_xk10_xk11 = zeros(13 - 11,1);

for k = 1:13 - 11
    f_xk_xk1_xk2_xk3_xk4_xk5_xk6_xk7_xk8_xk9_xk10_k11(k) = (f_xk_xk1_xk2_xk3_xk4_xk5_xk6_xk7_xk8_xk9_xk10(k+1) - f_xk_xk1_xk2_xk3_xk4_xk5_xk6_xk7_xk8_xk9_xk10(k)) / (t(k+11) - t(k));
end

f_xk_xk1_xk2_xk3_xk4_xk5_xk6_xk7_xk8_xk9_xk10_k11_xk12 = zeros(13 - 12,1);

for k = 1:13 - 12
    f_xk_xk1_xk2_xk3_xk4_xk5_xk6_xk7_xk8_xk9_xk10_k11_xk12(k) = (f_xk_xk1_xk2_xk3_xk4_xk5_xk6_xk7_xk8_xk9_xk10_xk11(k+1) - f_xk_xk1_xk2_xk3_xk4_xk5_xk6_xk7_xk8_xk9_xk10_xk11(k)) / (t(k+12) - t(k));
end

P = @(x) f_xk(1) + ...
    f_xk_xk1(1) .* (x - t(1)) + ...
    f_xk_xk1_xk2(1) .* (x - t(1)) .* (x - t(2)) + ...
    f_xk_xk1_xk2_xk3(1) .* (x - t(1)) .* (x - t(2)) .* (x - t(3)) + ...
    f_xk_xk1_xk2_xk3_xk4(1) .* (x - t(1)) .* (x - t(2)) .* (x - t(3)) .* (x - t(4)) + ...
    f_xk_xk1_xk2_xk3_xk4_xk5(1) .* (x - t(1)) .* (x - t(2)) .* (x - t(3)) .* (x - t(4)) .* (x - t(5)) + ...
    f_xk_xk1_xk2_xk3_xk4_xk5_xk6(1) .* (x - t(1)) .* (x - t(2)) .* (x - t(3)) .* (x - t(4)) .* (x - t(5)) .* (x - t(6)) + ...
    f_xk_xk1_xk2_xk3_xk4_xk5_xk6_xk7(1) .* (x - t(1)) .* (x - t(2)) .* (x - t(3)) .* (x - t(4)) .* (x - t(5)) .* (x - t(6)) .* (x - t(7)) + ...
    f_xk_xk1_xk2_xk3_xk4_xk5_xk6_xk7_xk8(1) .* (x - t(1)) .* (x - t(2)) .* (x - t(3)) .* (x - t(4)) .* (x - t(5)) .* (x - t(6)) .* (x - t(7) .* (x - t(8))) + ...
    f_xk_xk1_xk2_xk3_xk4_xk5_xk6_xk7_xk8_xk9(1) .* (x - t(1)) .* (x - t(2)) .* (x - t(3)) .* (x - t(4)) .* (x - t(5)) .* (x - t(6)) .* (x - t(7)) .* (x - t(8)) .* (x - t(9)) + ...
    f_xk_xk1_xk2_xk3_xk4_xk5_xk6_xk7_xk8_xk9_xk10(1) .* (x - t(1)) .* (x - t(2)) .* (x - t(3)) .* (x - t(4)) .* (x - t(5)) .* (x - t(6)) .* (x - t(7)) .* (x - t(8)) .* (x - t(9)) .* (x - t(10)) + ...
    f_xk_xk1_xk2_xk3_xk4_xk5_xk6_xk7_xk8_xk9_xk10_xk11(1) .* (x - t(1)) .* (x - t(2)) .* (x - t(3)) .* (x - t(4)) .* (x - t(5)) .* (x - t(6)) .* (x - t(7)) .* (x - t(8)) .* (x - t(9)) .* (x - t(10)) .* (x - t(11))+ ...
    f_xk_xk1_xk2_xk3_xk4_xk5_xk6_xk7_xk8_xk9_xk10_k11_xk12(1) .* (x - t(1)) .* (x - t(2)) .* (x - t(3)) .* (x - t(4)) .* (x - t(5)) .* (x - t(6)) .* (x - t(7)) .* (x - t(8)) .* (x - t(9)) .* (x - t(10)) .* (x - t(11)) .* (x - t(12));

figure(2)
x = linspace(0,13, 1000);
plot(x, P(x))
% ... well, this didn't work and it looks extremely messy, even worse than
% I anticipated that the Lagrange polynomial would look. Yuck.
% since this looks horrible, I'll move on to the next for now:

% B. Piece-wise linear interpolation through all points.
% cheat: do with MATLAB's built-in function for linear interpolation
figure(3)
plot(m', t')
% I'm looking to glue these vectors together in the end
v1 = []; v2 = []; v3 = []; v4 = []; v5 = []; v6 = []; v7 = [];
v8 = []; v9 = []; v10 = []; v11 = []; v12 = [];

gradient_list = [];
gradient_list(1) = (t(2) - t(1)) / (m(2) - m(1));
gradient_list(2) = (t(3) - t(2)) / (m(3) - m(2));
gradient_list(3) = (t(4) - t(3)) / (m(4) - m(3));
gradient_list(4) = (t(5) - t(4)) / (m(5) - m(4));
gradient_list(5) = (t(6) - t(5)) / (m(6) - m(5));
gradient_list(6) = (t(7) - t(6)) / (m(7) - m(6));
gradient_list(7) = (t(8) - t(7)) / (m(8) - m(7));
gradient_list(8) = (t(9) - t(8)) / (m(9) - m(8));
gradient_list(9) = (t(10) - t(9)) / (m(10) - m(9));
gradient_list(10) = (t(11) - t(10)) / (m(11) - m(10));
gradient_list(11) = (t(12) - t(11)) / (m(12) - m(11));
gradient_list(12) = (t(13) - t(12)) / (m(13) - m(12));

lin_pol = @(x0, x, y1, grad) y1 + grad.*x - grad.*x0;

x = linspace(m(1), m(2), 100);
y = lin_pol(m(1), x, t(1), gradient(1));
figure(4)
plot(x,y)

% ... I don't quite see why it doesn't ... it becomes a horizontal line.

% C. Splines-approximation though all points.
% note: this uses joint approximations of lower degree polynomials instead
% of one all-encompassing approximation with a high degree polynomial.
% Doing it this way avoids Runge's phenomenon.

% D. Second degree polynomial from june to august.

% E. Least squares approximation of a second order polynomial using data
% from april to september.

% F. Same thing as in E but now with all the data.

% G. Approximate data with y = c1 + c2*cos(w*x) + c3*sin(w*x) + ...
% where w is an impostor omega and is equal to 2*pi / 365.

% Now look your results. 
% a. which ansatz demanded the greatest number of coefficients to be
% determined?

% b. Four only needed 3 coefficients. Which ones?

% c. Which is most useful for finding the longest day of the year? Why?
% what was the solstice hour count?

% d. same as c but for christmas eve. Anticipate Runge's phenomenon.

% e. Which method do you think is best? Why? Hint: Fourier series rule.
