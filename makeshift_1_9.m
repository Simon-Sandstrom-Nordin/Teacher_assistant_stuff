% Domo
%% Uppgift 6
%a)
xa = 0:1e-9:1e-4;
yf = 0.0027;
ya = funktion6(xa);

plot(xa, ya);
hold on
title('Integrand')
xlabel('x')
ylabel('ya');
hold on 
yline(yf)
%Funktionen borde inte oscillera, täljaren är alltid positiv. 
%Oscillationen sker p.g.a. att så små x-värden multipliceras med varandra i
%nämnaren varav avrundningsfel sker. 

%% c)Vi approximerar integranden av ett Taylorpolynom p = 0, 
%varav vi får att lim (x=>0) f(x) = 1/375 (L'hopitals)
%Vi plottar även funktionen för lite större x-värden varav
%vi kan konstatera att den liknar en konstant y = 0.00266667
xc = 0:1e-9:2.3e-3;
yHopitals = 1/375;
yc = funktion6(xc);

plot(xc, yc);
hold on
title('Integrand')
xlabel('xc')
ylabel('yc');
ylim([1e-3 4e-3])
hold on 
yline(yHopitals)

FEL_1 = abs(yHopitals - 0.0026667)*xc(end);
%Således kan vi andvända yHopitals som integrand för intervallet 0:3e-3 där
%dess fel är FEL_1
%% d) Vi kollar ohur funktionen ser ut mellan x = 1e-4:B; 
FEL_svans = (1e-9)/4; %Mindre än egentligen
B = 10^3*sqrt(2/3);
xd = 1e-4:0.1:50;
yd = funktion6(xd);
plot(xd,yd); 
%Vi konstaterar att majoriteten av integralen är mellan x = 1e-4:40 
%varav vi bestämmer att dela upp beräkaningen i två integraler som 
%vi löser med trapetsregeln varav ena har kortare steglängd

%% e) och f)
%Beräknar den första delen av integralen
x1 = 3e-3;
y1 = yHopitals;
FEL_1 = FEL_1;
Del_1 = x1*y1;
table(Del_1, FEL_1, 'VariableNames',{'T(h)_1','delta'})

%%Beräknar andra delen x = 3e-3:40; (Trapetsregeln)
[Del_2, FEL_2, steglangd2, Del_2rich, FEL_2rich] = Trapregel(x1, 40+x1, 320); %OBS x1 = 3e-3
table(Del_2, FEL_2, steglangd2, Del_2rich, FEL_2rich, 'VariableNames',{'T(h)_2','delta','h', 'T^(h)_2', 'delta-rich'})

%%Beräknar tredje delen x = 40:B; (Trapetsregeln)
[Del_3, FEL_3, steglangd3, Del_3rich, FEL_3rich] = Trapregel(40+x1, ceil(B)+x1, 160);
table(Del_3, FEL_3, steglangd3, Del_3rich, FEL_3rich, 'VariableNames',{'T(h)_3','delta','h', 'T^(h)_3', 'delta-rich'})
%% f
Integral_tot = Del_1 + Del_2rich(end) + Del_3rich(end);
FEL_tot = FEL_1 + FEL_2rich(end) + FEL_3rich(end) + FEL_svans;

table(Integral_tot, FEL_tot)
%Avrundar värdet på integralen till 0.01785934

FEL_pres = abs(0.01785934 - Integral_tot);
FEL_range = FEL_tot + FEL_pres;
%Avrundar värdet på felet till 9.3e-10

I_svar = 0.01785934;
FEL_svar = 9.3e-10;
table(I_svar, FEL_svar)

%% Uppgift 7
%a)
%Integrandens derivata har ett nollställe > x = pi/11. Detta ger ända
%toppen för intervallet, vi plottar grafen kring detta x-värde
%Före 0.285 är integranden 0, efter 0.287 är den också 0.
%Således kan integralen beräknas över detta intervall. 
a = 0.2840; 
b = 0.2875;
TOL = 1e-10;

x = a:0.00001:b;
y = funktion7(x);
plot(x,y)

I_quad = quad(@funktion7, a, b, TOL);
I_integral = integral(@funktion7, a, b);

table(I_quad, I_integral)

%% Uppgift 8
y_8 = Eulerf(0, 4, 8, 2.5); %Steglängd 0.5
x_8 = 0:0.5:4;

y_16 = Eulerf(0, 4, 16, 2.5); %Steglängd 0.25
x_16 = 0:0.25:4;

y_32 = Eulerf(0, 4, 32, 2.5); %Steglängd 0.125
x_32 = 0:0.125:4; 

plot(x_8, y_8, '-r')
hold on
plot(x_16, y_16, '-b')
hold on 
plot(x_32, y_32, '-k')
xlabel('x')
ylabel('y(x)')
title('r-0.5 b-0.25 k-0.125')

table(y_8(end), y_16(end), y_32(end), 'VariableNames',{'h = 0.5','h = 0.25','h = 0.125'})

%% b)

for  i = 1:10
    N = 2^(2+i);
    Nvec(i) = N;
    yv = Eulerf(0, 4, N, 2.5);
    y4(i) = yv(end);
    
    if i > 1
        deltavec(i) = (y4(i) - y4(i-1));
    end
    
end

table(y4', deltavec', Nvec', 'VariableNames',{'y(4)','delta','N'})
plot(0.5.^(7:10), deltavec(6:9));

%% Uppgift 9

L = 4;
a = 0;
b = L;

y0 = 2.5;


Neuler = 4096*8;
y_9= Eulerf(0, 4, Neuler, 2.5);
y_92 = y_9.^2;

[Ivec, Delta, N, Irichvec, Deltarich] = T9(4, y_92, Neuler/8);
Vvec = pi.*Ivec;
Vdelta = pi.*Delta;

Vrichvec = pi.*Irichvec;
Vdeltarich = pi.*Deltarich;

table(Vvec, Vdelta, N, Vrichvec, Vdeltarich, 'VariableNames',{'V','delta','N', 'V_rich', 'delta_rich'})
%11.835 6.236292103522355e-04

%% b)
Volym_4 = Vvec(end);

L_n_2 = 4;
%Volym_n_2 = Volym_4;

L_n_1 = 2;
%Volym_n_1 = T9_b(3, y_92)
funktion9 = @(x) T9_b(x, y_92) - 0.7*Volym_4;

counter = 0;
TOL = 1e-4;
Enew = 1;
Lv = [];
Ev = [];
counterv = [];
Ekvotv = [];
while (Enew>TOL)
    L_n = L_n_1 - ((L_n_1 - L_n_2)/(funktion9(L_n_1) - funktion9(L_n_2)))*funktion9(L_n_1);
    Eold = Enew;
    Enew = abs(L_n - L_n_1);
    L_n_2 = L_n_1;
    L_n_1 = L_n;
    counter = counter + 1;
    Ev(end+1) = Enew;
    Lv(end+1) = L_n;
    counterv (end+1) = counter;
    Ekvotv(end+1) = Enew/Eold;
end

table(Lv', Ev', Ekvotv', counterv', 'VariableNames',{'L','Fel','Fel-kvot', 'Counter'})

L_slut = Lv(end);
Volym_slut = T9_b(L_slut, y_92);
Volym_exakt = 0.7*Volym_4;
Volym_skillnad = abs(Volym_slut - Volym_exakt);

table(L_slut, Volym_slut, Volym_exakt, Volym_skillnad)

%Volym_4*0.7
%T9_b(3, y_92)
%T9_b(2, y_92)

%2.80 1.371998603834079e-04



%Vi bestämmer att använda oss av sekant metoden 


%% c)
f = Eulerf(0, 4, 4096, 2.5);
fc = f(1:(4096/40):end);
i = (0:(4/40):4)';

fi = 0:((2*pi)/40):2*pi;

X = i*ones(size(fi));
Y = fc*cos(fi);
Z = fc*sin(fi);
surf(X,Y,Z)
xlabel('x')
ylabel('y')
zlabel('z')







