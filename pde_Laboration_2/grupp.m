clc; clear; close all;

N = 6;
L = 1;
x0 = 0;
h = (L-x0)/N;

% f(x)
f = @(x) x;

% a(x)
a = @(x) x;

% styvhetsmatris
A = zeros(N,N);

% lastvektor
l = zeros(N,1);

% dubbel foor-loop för A
for i = 1:N
    for j = 1:N

        % huvuddiagonal
        if i == j
            A(i,j) = N^2 * 2 * h * a(h);
        end


    end
end



% foor-lop för l
for l_index = 1:N
    l(l_index) = 2*h*f(h);
    % speciallösning kanske krävs för N= 6
end


