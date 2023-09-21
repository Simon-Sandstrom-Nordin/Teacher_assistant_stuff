clc; clear; close all;

inte = @(x0) integral(@(x) exp(-pi.*(x-x0).^2) .* ((-1/2).*(-pi + pi^2 .* (x - x0).^2) + (x.^2) ./ 2 + (x.^4) ./ 2) , -inf, inf);

x0_list = linspace(-.001,.001, 1000);
int_list = []
for k = 1:length(x0_list)
    int_list(end + 1) = inte(x0_list(k))
end
plot(x0_list, int_list, 'ro')
