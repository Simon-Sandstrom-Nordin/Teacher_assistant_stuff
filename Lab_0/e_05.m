% create table or the likes of it of data.
% From Merrian Webster:
%   2. information in digital form that can be transmitted or processed
% ... I'll take "digital form" as sequences of ones and zeros. But then
% is hexadecimal code data? ... I'll just take it a digital info.
clc; clear; close;

f = @(x) x / 20 - 2 -3 * exp(-x);
x = 0:.5:5; f_x = f(x);
T = 'x and f(x) in tandem in a table';
VariableNames = {'x','f(x)'};
T = table(x', f_x', 'VariableNames', VariableNames);
disp(T)

% Note: inbyggda funktionen table() är överkurs. ... fast enkel.
% Matriser räcker om saker och ting inte behöver vara så städade:

[x', f_x']