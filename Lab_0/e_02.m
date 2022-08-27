% Multiply two vectors, and see the results.
clc; clear all; close all;

x = [2, 3]; y = [5, 7]';

a = x * y   % scalar multiplication. 2*5 + 3*7
b = y * x   % [10 15; 14 21] = [5;7]*[2,3] = [5*2, 5*3; 7*2; 7*3]
c = x .* y' % element-wise multiplication. [2*5, 3*7]
% d = x'*y    % invalid scalar multiplication. 2 * 1 times 2 * 1.
e = x./y'   % element-wise division. [.4 .4286] = [5/2 3/7]. 1*2 times 2*1.


