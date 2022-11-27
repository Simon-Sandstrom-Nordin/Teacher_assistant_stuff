function giss_value = T_Lgiss(giss)
    T0 = 315; 
    T_L = 445;
    L = 3.60;
    tspan = [0 L];
    
    U0 = [T0, giss];
    f3 = @(t, U) [U(2); (-280*(exp(-(t - L/2)^2)))/(2 + t/3) - U(2)/(6 + t)];
    [t, Tv] = ode45(f3, tspan, U0);
    giss_value = Tv(end, 1);
end