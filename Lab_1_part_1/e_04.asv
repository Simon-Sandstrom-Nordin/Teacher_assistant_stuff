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

% B. Piece-wise linear interpolation through all points.

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
