clc; clear all; close all;

a = .9; % excentricity, between [0,1)


q0 = [1-a, 0]';
p0 = [0, sqrt((1+a) / (1-a))]';
h = .0001;

q_matrix = [q0]; p_matrix = [p0];
for k = 1:70000
    q_matrix = [q_matrix, q_matrix(:, end) + h.*p_matrix(:, end)];
    p_matrix = [p_matrix, p_matrix(:, end) - h.*q_matrix(:, end)./(norm(q_matrix(:, end)).^3)];
end
plot(q_matrix(1,:)', q_matrix(2,:)', 'o'); axis equal
%% 
clc; clear all; close all;
disp("hi")

a = .9; % excentricity, between [0,1)
q0 = [1-a, 0]';
p0 = [0, sqrt((1+a) / (1-a))]';
h = .0001;

q_matrix = [q0]; p_matrix = [p0];
for k = 1:70000
    q_matrix = [q_matrix, q_matrix(:, end) + h.*p_matrix(:, end)];
    p_matrix = [p_matrix, p_matrix(:, end) - h.*q_matrix(:, end)./(norm(q_matrix(:, end)).^3)];
end
plot(q_matrix(1,:)', q_matrix(2,:)', 'o')