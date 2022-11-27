clc; clear all; close all; format long;
% Uppgift 8
yp = @(x,y) -(1/6 + pi .* sin(pi.*x) ./ (1.5 - cos(pi.*x))).*y;
t = linspace(0,4,.5);
y0 = 2.5;
max_iter = 10;
L = 4;
h0 = .5;

figure("Name","ode45")
ode45(yp,[0,4],y0)

figure("Name","Euler")
last_y_vector = [];
for iter = 1:max_iter
    h = h0 * .5^(iter-1);
    x_list = [0];
    y_list = [y0];
    for k = h:h:L
            k_1 = yp(k,y_list(end));
            k_2 = yp(k+0.5*h,y_list(end)+0.5*h*k_1);
            k_3 = yp((k+0.5*h),(y_list(end)+0.5*h*k_2));
            k_4 = yp((k+h),(y_list(end)+k_3*h));
            y_list(end+1) = y_list(end) + (1/6)*(k_1+2*k_2+2*k_3+k_4)*h;  % main equation
        %y_list(end + 1) = y_list(end) + h*yp(x_list(end),y_list(end));
        x_list(end + 1) = k;
    end
    plot(x_list, y_list)
    hold on
    last_y_vector(end+1) = y_list(end);
end
last_y_vector'
% Uppgift 9
V = @(y) pi .* y.^2;
vol_list = [];
for iter = 1:max_iter
    h = h0 * .5^(iter-1);
    x_list = [0];
    y_list = [y0];
    for k = h:h:L
            k_1 = yp(k,y_list(end));
            k_2 = yp(k+0.5*h,y_list(end)+0.5*h*k_1);
            k_3 = yp((k+0.5*h),(y_list(end)+0.5*h*k_2));
            k_4 = yp((k+h),(y_list(end)+k_3*h));
            y_list(end+1) = y_list(end) + (1/6)*(k_1+2*k_2+2*k_3+k_4)*h;  % main equation
        %y_list(end + 1) = y_list(end) + h*yp(x_list(end),y_list(end));
        x_list(end + 1) = k;
    end

    vol = trapz(x_list, V(y_list));
    vol_list(end+1) = vol;
end
vol_list'

% b
% Uppgift 9
V = @(y) pi .* y.^2;
V_7 = vol_list(end) * .7;

L_saughts = [];
for iter = 2:max_iter
    
    L_list = [];
    V_list = [];
    for L = 1:h:4
        h = h0 * .5^(iter);
        x_list = [0];
        y_list = [y0];
        for k = h:h:L
                k_1 = yp(k,y_list(end));
                k_2 = yp(k+0.5*h,y_list(end)+0.5*h*k_1);
                k_3 = yp((k+0.5*h),(y_list(end)+0.5*h*k_2));
                k_4 = yp((k+h),(y_list(end)+k_3*h));
                y_list(end+1) = y_list(end) + (1/6)*(k_1+2*k_2+2*k_3+k_4)*h;  % main equation
            %y_list(end + 1) = y_list(end) + h*yp(x_list(end),y_list(end));
            x_list(end + 1) = k;
        end
    
        vol = trapz(x_list, V(y_list));
        L_list(end + 1) = L;
        V_list(end + 1) = vol;
    end
    V_7 = V_list(end) * .7;
    figure("Name", "V over L" + "iter: " + iter)
    plot(L_list, V_list, 'ro')
    hold on
    index = 0;
    for index = 1:length(L_list)
        if V_list(index) > V_7
            break
        end
    end
    % linear interpolation
    V_before = V_list(index - 1);
    V_after = V_list(index);
    L_before = L_list(index - 1);
    L_after = L_list(index);
    gradient = (V_after - V_before)/(L_after - L_before);
    line = @(L) V_before + gradient*(L-L_before) - V_7; 
    plot(linspace(L_before, L_after), line(linspace(L_before, L_after)) + V_7, 'b-')
    L_saught = fzero(line, [0,4])
    L_saughts(end + 1) = L_saught;
end
L_saughts
% c

i = (0:(4/40):4)';
fi = 0:((2*pi)/40):2*pi;

last_y_vector = [];
N = 40;
h = h0;
x_list = [0];
y_list = [y0];
for k = h:h:L
    y_list(end + 1) = y_list(end) + h*yp(x_list(end),y_list(end));
    x_list(end + 1) = k;
end
figure(99)
plot(x_list, y_list)

X = x_list'*ones(size(fi));
Y = y_list'*cos(fi);
Z = y_list'*sin(fi);
figure(13)
surf(X,Y,Z)
xlabel('x')
ylabel('y')
zlabel('z')
figure(14)
mesh(X,Y,Z)
xlabel('x')
ylabel('y')
zlabel('z')
