clc; clear all; close all;
L_list = linspace(0, 4); L_list = L_list(2:end);
V_list = [];
for L = 1:length(L_list)
    V_list(end + 1) = t_9_new(L_list(L));
end

figure(5)
plot(L_list, V_list)
