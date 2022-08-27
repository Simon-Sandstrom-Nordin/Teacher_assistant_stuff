% plot a function. ez.
clc; clear; close;

f =  @(x) x.^3 / 20 - 2 - x.^3 .* exp(-x);
x = linspace(0,5);

plot(x, f(x), 'o'); xlabel('x'); ylabel('f(x)'); title('f(x) over x')
% instructionerna skriver "välj lämpligt tabellsteg". Är detta avståndet
% mellan varje x-värde?
