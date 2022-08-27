% explore matrix multiplication in MATLAB.
clc; clear all; close all;

A = [1,2; 3,4]

B = A^2         % A*A. Normal matrix multiplication. [7,10;15,22]
C = A.^2        % element-wise multipliation. [1, 4; 9, 16]. Here it's just
                % squaring all entries.
D = A^(-1)      % calculates the inverse matrix 
right_inverse = A*D % Checks out! = I = = [1,0;0,1]
left_inverse = D*A  % Also checks out. Inverse from the left! -II- right!

E = A.^(-1)     % inverts element-wise. [1/1 1/2; 1/3, 1/4]
