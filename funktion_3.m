function [t, Tv] = funktion_3(T_primkorrekt)
    T0 = 315; 
    T_L = 445;
    L = 3.60;
    tspan = [0 L];
    
    U0 = [T0, T_primkorrekt];
    f3 = @(t, U) [U(2); (-280*(exp(-(t - L/2)^2)))/(2 + t/3) - U(2)/(6 + t)];
    [t, Tv] = ode45(f3, tspan, U0);
end