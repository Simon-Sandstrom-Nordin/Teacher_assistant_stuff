function [function_value, derivative_value] = test_function(a,b,c,x)
function_value = a + b*x + c*x^2;
derivative_value = b + 2*c*x;
end
