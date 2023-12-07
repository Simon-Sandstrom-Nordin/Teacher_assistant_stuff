clear; close; clc;

% built in control toolbox
sys = tf([1, 3], [1, 3, 5, 1]);
figure()
rlocus(sys)

% manual programming
K_vector = linspace(0,1000,10000);
NoK = length(K_vector);
x_vec = zeros(NoK, 3);
y_vec = zeros(NoK, 3); % why 3?

for n = 1:NoK
    K = K_vector(n);
    C = [1, 3, 5+K, 1+3*K]; % fourth degree polynomial => exists exactly 3 complex roots by fundamental theorem of algebra?
    r = roots(C).';
    x_vec(n,:) = real(r);
    y_vec(n,:) = imag(r);
end
figure()
plot(x_vec, y_vec);
grid on;
