clc; clear all; close all;

% a. Where does it land? (measured horizontally from the starting point)
% starting conditions
% first run
b = 2*pi*6/(360);  % degrees in radians from vertical axis
y = .1; % meters
x = 0;
m = .25;    % kg at start
v = 0;
t = 0;
h = .001;
max_iter = 65000;


function 