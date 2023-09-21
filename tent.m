clc; clear all; close all;

f = @(x1, x2, ep) log(x1.^2 + x2.^2) ./ log(ep);

x1 = linspace(-1,1, 1000); x2 = linspace(-1,1, 1000); ep = .01;

[xx1, xx2] = meshgrid(x1, x2);
uu = f(xx1, xx2, ep);
size_of_uu = size(uu);
for row = 1:size_of_uu(1)
    for column = 1:size_of_uu(2)
        if (uu(row,column) < 0) || (uu(row,column) > 1)
            uu(row, column) = 0;
        end
    end
end

figure(1)
mesh(uu);