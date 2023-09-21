clc; clear all; close all;

% anonymous functions
g1 = @(x) x.*(pi - x);  
g2_1 = @(x) x; g2_2 = @(x) 0;

% parameters
x_end = pi; t_end = 3;

% calculate deltas
delta_x = x_end/3;
delta_t = t_end/15;

figure(1)
for counter = 1:2
delta_x = delta_x * .5^1;
delta_t = delta_t * .5^2;

% check stability
if delta_t/(delta_x)^2 > (1/2)
    disp("unstable solution")
end

% set up arrays
x = 0:delta_x:x_end;
t = 0:delta_t:t_end;
u = zeros(length(t), length(x));

% boundry condition at t = 0
for k = 1:length(x)
    %u(1,k) = g1(x(k));
    if x(k) < pi/2
        u(1,k) = g2_1(x(k));
    else
        u(1,k) = g2_2(x(k));
    end
end

%
for row = 1:length(t)-1
    for column = 2:length(x)-1  % disincluding boundry
        u(row + 1, column) = u(row, column) + ...
            (delta_t/(delta_x^2)) * ...
            (u(row, column+1) - 2*u(row, column) + u(row, column-1));
    end
end

if counter == 2
    %disp("...")
    %u
    %disp("hh")
    t = 0:delta_t*4:t_end;
    x = 0:delta_x*2:x_end;
    u_new = zeros(length(t), length(x));
    for row = 1:length(t)
        for column = 1:length(x)-1
            u_new(row, column) = u(4*row-3, 2*column-1);
        end
    end
    %u_new
    hold on;
    mesh(u_new); 
else
    hold on;
    mesh(u);
    %disp(u)
end
end

% fourier stuff
% calculate deltas
delta_x = x_end/3;
delta_t = t_end/15;

% figure(2)
% for counter = 1:2
% % b_n = (1/(pi*n^3)) * (4 - 2*pi*n*sin(n*pi) - 4*n*cos(pi*n))
% N = 20*counter;
% f = @(x, t) 0;
% for n = 1:N
%     term = @(x, t) (1/(pi*n^3)) * (4 - 2*pi*n*sin(n*pi) - 4*n*cos(pi*n)) ...
%         .* sin(n*x) .* exp(-t*n^2);
%     f = @(x,t) f(x,t) + term(x,t);
% end
% 
% delta_x = delta_x * .5^1;
% delta_t = delta_t * .5^2;
% 
% % check stability
% if delta_t/(delta_x)^2 > (1/2)
%     disp("unstable solution")
% end
% 
% % set up arrays
% x = 0:delta_x:x_end;
% t = 0:delta_t:t_end;
% 
% u = zeros(length(t), length(x));
% for row = 1:length(t)
%     for column = 1:length(x)
%         u(row, column) = f(x(column), t(row));
%     end
% end
% 
% if counter == 2
%     %disp("...")
%     %u
%     %disp("hh")
%     t = 0:delta_t*4:t_end;
%     x = 0:delta_x*2:x_end;
%     u_new = zeros(length(t), length(x));
%     for row = 1:length(t)
%         for column = 1:length(x)-1
%             u_new(row, column) = u(4*row-3, 2*column-1);
%         end
%     end
%     %u_new
%     hold on;
%     mesh(u_new); 
% else
%     hold on;
%     mesh(u);
%     %disp(u)
% end
% end
