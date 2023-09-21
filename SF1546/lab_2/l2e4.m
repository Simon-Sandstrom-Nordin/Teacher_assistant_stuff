% Randvärdesproblem
clc; clear all; format long

% Constants
T_0 = 305;  T_L = 445;   % [K]
x_0 = 0;    L = 3.80;    % [L]

% Functions
k = @(x) 2 + x./7;
kx = @(x) 1/7;
Q = @(x) - 290 .* exp(-(x-L/2).^2);

% Parameters
%n = 4;

% lists with x_values
x_1_75 = [];
x_2_47 = [];
T_max = [];

%tested by for-looping
%n = 228 works for 1.75
%n = 20 works for 2.47
% for n = 2:300
% h = L/n;
% list = [];
% for i = 0:n
% list(end+1) = h*i;
% end
% if ismember(1.75, list)
% disp("two " + num2str(n))
% end
% end

figure(1)
for jj = 0:0
    n = 20;  % This also needs to be here
    %n = 228;  % This also needs to be here
    n = n * 2^(jj);
    h = (L-x_0)/n;    % 0 <= x <= L % needs be defined here.
    % Lists
    x_list = zeros(n+1, 1);
    for j = 0:n
        x_list(j+1) = x_0 + j*h;
    end
    q_list = Q(x_list(2:end-1));

    % Matrix
    A = zeros(n-1,n-1);
    b = zeros(n-1,1);

    % load b
    b(1) = -(-kx(x_0)/(2*h) + k(x_0)/(h^2))*T_0 + q_list(1); 
    b(end) = -(kx(L)/(2*h) + k(L)/(h^2))*T_L + q_list(end);
    for j = 2:n-1-1
        b(j) = q_list(j);
    end

    % load lists to be used with diag(vector, index)
    higher = zeros(n-2, 1);
    for j = 1:n-2
        higher(j) = kx(x_list(j+2))/(2*h) + k(x_list(j+2))/(h^2);
    end
    middle = zeros(n-1, 1);
    for j = 1:n-1
        middle(j) = -2*(k(x_list(j+1)))/(h^2);
    end
    lower = zeros(n-2, 1);
    for j = 1:n-2
        lower(j) = -kx(x_list(j+1))/(2*h) + k(x_list(j+1))/(h^2);
    end
    
    A = A + diag(higher, 1);
    A = A + diag(middle, 0);
    A = A + diag(lower, -1);
    % A = sparse(A);  % For memory efficiency.
    
    T = A \ b;
    T = [T_0; T; T_L];  % add endpoints
    hold on
    plot(x_list(1:end), T, 'k')
    x_2_47(end+1) = T(find(x_list == 2.47));
    %x_1_75(end+1) = T(find(x_list == 1.75));
end
x_2_47'
%    1.0e+02 *
% 
%    5.316339388516456
%    5.316308613180865
%    5.316300919605469

%x_1_75'
%    1.0e+02 *
% 
%    5.332475726171300
%    5.332454095032770
%    5.332448687407832