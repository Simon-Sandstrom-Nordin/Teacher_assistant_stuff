% Randvärdesproblem
clc; clear all; format long

% Constants
T_0 = 315;  T_L = 445;   % [K]
x_0 = 0;    L = 3.60;    % [L]

% Functions
k = @(x) 2 + x./3; 
Q = @(x) - 280 .* exp(-(x-L/2).^2); % remember the minus sign, Simon.

% Parameters
%n = 4;

% lists with x_values
x_1_65 = [];
x_3_12 = [];
T_max = [];

figure(1)
for jj = 0:1
    n = (L-x_0)*100;  % This also needs to be here
    %n = 24
    n = n * 2^(jj);
    h = (L-x_0)/n;    % 0 <= x <= L % needs be defined here.
    % Lists
    x_list = zeros(n+1, 1);
    for j = 0:n
        x_list(j+1) = x_0 + j*h;
    end
    %disp("x"); disp(x_list);
    
    q_list = Q(x_list(2:end-1));
    %disp("q"); disp(q_list);

    %k_list = k(x_list(1:end));
    %disp("k"); disp(k_list);
    
    % Matrix
    A = zeros(n-1,n-1);
    b = zeros(n-1,1);
    %disp("A"); disp(A);

    % load b
    b(1) = -(2/(h^2) + x_list(2)/(3*h^2) - 1/(6*h))*T_0 + q_list(1);
    b(end) = -(2/(h^2) + x_list(end-1)/(3*h^2) + 1/(6*h))*T_L + q_list(end);
    for j = 2:n-2
        b(j) = q_list(j);
    end
    %disp("b"); disp(b);
    % load A
    %for a = 1:n
    %    for b = 1:n
    %        for c = 1:n
    %    higher = 2/(h^2) + x_list(1)/(3*h^2) + 1 / (6*h);
    %    mid = -(4/(h^2) + 2*x_list(1)/(3*h^2));
    %    lower = 2/(h^2) + x_list(1)/(3*h^2) - 1/(6*h);
    %        end
    %    end
    %end
    % Actually, scratch the whole idea of using for loops.
    
    % load lists to be used with diag(vector, index)
    higher = zeros(n-2, 1);
    for j = 1:n-2
        higher(j) = 2/(h^2) + x_list(j+2)/(3*h^2) + 1/(6*h);
    end
    middle = zeros(n-1, 1);
    for j = 1:n-1
        middle(j) = -(4/(h^2) - 2*x_list(j+1)/(3*h^2));
    end
    lower = zeros(n-2, 1);
    for j = 1:n-2
        lower(j) =  2/(h^2) + x_list(j+1)/(3*h^2) - 1/(6*h);
    end
    
    A = A + diag(higher, 1);
    A = A + diag(middle, 0);
    A = A + diag(lower, -1);
    %A = sparse(A);  % For memory efficiency.
    
    T = A \ b;
    T = [T_0; T; T_L];  % add endpoints
    hold on
    x_vector = linspace(x_0, L, numel(T)); % useful for plotting later
    plot(x_vector, T, 'k')

    % add values and shit
    %x_1_65(end+1) = T(find(x_vector == 1.65));
    %x_3_12(end+1) = T(find(x_vector == 3.12));
    % didn't work, they don't become exactly that. Find them!

    x_1_65_index = 0;
    for k = 1:length(x_vector)
        if x_vector(k) > 1.65
            x_1_65_index = k;   % This'll take the upper point
            break
        end
    end
    x_3_12_index = 0;
    for k = 1:length(x_vector)
        if x_vector(k) > 3.12
            x_3_12_index = k;   % This'll take the upper point
            break
        end
    end
    
    % Takes midpoint value
    %x_1_65(end+1) = ( T(x_1_65_index) + T(x_1_65_index-1) ) / 2;
    %x_3_12(end+1) = ( T(x_3_12_index) + T(x_3_12_index-1) ) / 2;
    %T_max(end+1) = max(T);
    %disp(jj)
    % not good enough

    % altered from t3.m
    % x = 1.65
    disp(x_vector(x_1_65_index - 1) + " " + T(x_1_65_index - 1))
    disp(x_vector(x_1_65_index) + " " + T(x_1_65_index))
    line = @(x) T(x_1_65_index) + ( (T(x_1_65_index)-T(x_1_65_index-1))/(x_vector(x_1_65_index) - x_vector(x_1_65_index - 1)) ).* (x - x_vector(x_1_65_index)) ;
    t = linspace(x_vector(x_1_65_index) - .5, x_vector(x_1_65_index) + .5);
    hold on
    plot(t, line(t), 'r')
    disp(line(1.65))

    % it shoots too far consistently
    %x_1_65(end + 1) = T(x_1_65_index - 1);
    x_1_65(end + 1) = line(1.65);

    % x = 3.12
    disp(x_vector(x_3_12_index - 1) + " " + T(x_3_12_index - 1))
    disp(x_vector(x_3_12_index) + " " + T(x_3_12_index))
    line = @(x) T(x_3_12_index) + ( (T(x_3_12_index)-T(x_3_12_index-1))/(x_vector(x_3_12_index) - x_vector(x_3_12_index - 1)) ).* (x - x_vector(x_3_12_index)) ;
    t = linspace(x_vector(x_3_12_index) - .5, x_vector(x_3_12_index) + .5);
    hold on
    plot(t, line(t), 'b')
    disp(line(3.12))
    % it shoots too far consistently
    %x_3_12(end + 1) = T(x_3_12_index - 1);
    x_3_12(end + 1) = line(3.12);

    T_max(end + 1) = max(T)
    %A
end
    
disp("x = 1.65")
disp(x_1_65')
disp("x = 3.12")
disp(x_3_12')
disp("T max")
disp(T_max')

for k = 1:length(x_1_65)-1
    disp(x_1_65(k+1) - x_1_65(k))
end