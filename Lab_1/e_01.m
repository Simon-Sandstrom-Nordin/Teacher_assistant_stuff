% Linjärt ekvationssystem, Ax = b, finn x.
clc; clear all; close all;

A = [1 2 3 0;
    0 4 5 0;
    1 1 -1 0;
    1 1 1 1];

b = [7 6 5 4]'; % apostrofen markerar transponering i MATLAB.

x = A \ b

% check:
A*x
% ... vilket är det vi ville ha. Men notera:
A*x == b    % ger inte en logical array med bara ettor. Trunkeringsfel
            % förekommer. Hur stora? Låt oss se:

r = b - A*x % r är här residualvektorn.
            % Residual ( tänk residualkalkylen från komplex analys )
            % "remaining after the greater part or quantity has gone:"

% ... dvs trunkeringsfel av ordning 10*(-15) i sista elementet. Datorn
% använder ett ändligt antal decimaler (egentligen bits va? i bas 2) för
% att representera talet, så... tja, machine-epsilon kallas den minsta
% skillnaden som datorn kan hantera och ligger nånstans på det vi fått.
% skriv in "eps" i terminalen, jag får "ans = 2.2204e-16".
