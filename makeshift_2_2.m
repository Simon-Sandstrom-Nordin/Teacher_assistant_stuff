% Domo

%% Uppgift 2
%b)
T0 = 315; 
T_L = 445;
L = 3.60;

Nv = [];
T_165_v = [];
felv = [];
T_165_richv = [0];
fel_richv = [0];
Kv = [];

T_165_old = 0;
T_165_rich_old = 0;
fel_old = 1;
N = 72;

Nmax = (2^4)*N;

for i = 1:8
    h = L/N;
    xp = (1.65/h) + 1;
    x = 0:h:L;

%Q = @(x) -280*(exp(x-(L/2))^2);

%M = zeros(Nmax,Nmax);

%Av = zeros(Nmax-1, 1);
%Bv = zeros(Nmax, 1);
%Cv = zeros(Nmax-1, 1);

%fA = @(x) (12 + 2.*x - h)./(6.*h^2);
%fB = @(x) (-12 -2.*x)./(3.*h^2);
%fC = @(x) (12 + 2.*x + h)./(6.*h^2);

    Av = [(12 + 2.*x(2:(end-1)) - h)./(6.*h^2), 0];
    Bv = [1, (- 12 -2.* x(2:(end-1)) )./(3.*h^2), 1];
    Cv = [0, (12 + 2.*x(2:(end-1)) + h)./(6.*h^2)];
    bV = [T0, -280.*(exp(-(x(2:(end-1))-(L/2)).^2)), T_L]';

    M = diag(Av, -1)+ diag (Bv, 0) + diag(Cv, 1);
    %M = sparse(M);

    Tv = M\bV;
    
    T_165_new = Tv(round(xp));
    T_165_v(end+1) = T_165_new;

    fel_new = T_165_new - T_165_old;
    felv(end+1) = fel_new;
    T_165_old = T_165_new;
    
    if i >= 2
        T_165_rich_new = T_165_new + fel_new/3;
        T_165_richv(end+1) = T_165_rich_new; 
        fel_rich = T_165_rich_new - T_165_rich_old; 
        fel_richv(end+1) = fel_rich;
        T_165_rich_old = T_165_rich_new;
    end
    
    K = fel_old/fel_new;
    Kv(end+1) = K;
    fel_old = fel_new;
    
    Nv(end+1) = N;
    N = N * 2;
end

table(Nv', T_165_v', felv', Kv', T_165_richv', fel_richv', 'VariableNames',{'N', 'T(1.65)','delta','fel_kvot/noggranhetsordning', 'T^(1.65)', 'delta-rich'})

plot(x, Tv);
title('T(x)');
%Presentation: 501.435495 +- 9e-07

%c) h = 0.24. L delas in i 15 delar.

%d) Eftersom man måste använda flera metoder blir det mer jobb att uppskatta
%felen samtidigt som alla metoderna tillger noggranhetsfel. Således blir
%det svårt att uppskatta hur stor noggranhet man måste ha från respektive
%metod.

%e) Först får man temperatur värden längs staven från bandmatris metoden.
%Sedan så använder man MKM kring de högsta värdena, och ansätter en
%andragradsfunktion. För att sedan skatta Etrunk måste man pröva MKM med
%anstättning av ett polynom med högre grad. Man måste även skatta Etrunk som
%bandmatris metoden ger genom att pröva olika steglängder. 
%Slutligen för att skatta Tmax så deriverar man MKM-funktionen och använder
%sedan fzero (Newton/Sekant) på derivatan för att hitta maxvärdet av MKM-funktionen
%Det innebär att man även får ett fel från ekvationslösningen. 


%% Uppgift 3
T0 = 315; 
T_L = 445;
L = 3.60;
T_primgiss = 150;

%y = T_Lgiss(x0)
fun = @(x) T_Lgiss(x) - T_L;
T_primkorrekt = fzero(fun, T_primgiss);

%giss_old = 50;
%[t, Tv, fel_old] = fel_3(giss_old);
%giss_new = 150;
%fel_new = 1;

%felv = [fel_old];
%gissv = [giss_old];

%while abs(fel_new)>1e-16
    %[t, Tv, fel_new] = fel_3(giss_new);
    
    %kvot = (giss_new-giss_old)/(fel_new - fel_old);
    
    %giss_old = giss_new;
    %fel_old = fel_new;
    %giss_new = giss_new - kvot*fel_new; 
    
    %felv(end+1) = fel_new;
    %gissv(end+1) = giss_new;
% end

[x, Tv] = funktion_3(T_primkorrekt);

T = Tv(:,1);
Tprim = Tv(:,2);

plot(x, T);
hold on
plot(L, T_L, '*')

%table(felv', gissv', 'VariableNames',{'Fel', 'Gissningar'})

table(x, T)

tMKM = [1.44, 1.53, 1.62, 1.71, 1.8];
TMKM = [4.89964370730382e+02, 4.95481464905184e+02, 5.00098810243536e+02, 5.03803732787095e+02, 5.06596612568405e+02];

%Andragrads approximation 

c_andra = polyfit(tMKM(1, 2:4), TMKM(1, 2:4), 2);

T_165_andra = polyval(c_andra, 1.65);

c_tredje = polyfit(tMKM(1, 2:5), TMKM(1, 2:5), 3);

T_165_tredje = polyval(c_tredje, 1.65);

E_trunk_interpolation = abs(T_165_tredje - T_165_andra);

E_trunk_ode = 1e-6;

E_trunk_tot = E_trunk_interpolation + E_trunk_ode;
%ode45 10e-3 (relativ) och 10e-6 (absolut)

table(T_165_andra, T_165_tredje, E_trunk_interpolation, E_trunk_ode, E_trunk_tot)

%totala felet är Etrunk plus Etrunk_ode45
