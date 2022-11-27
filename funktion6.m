function y = funktion6(x)
    p = -((x./5).^3);
    t = 1 - exp(p);
    n = 3.*x.^3;
    y = t./n;
end