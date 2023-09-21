clc; clear all; close all;

% a. Where does it land? (measured horizontally from the starting point)
% starting conditions
% first run
disp("a")
b = 2*pi*6/(360);  % degrees in radians from vertical axis
y = .1; % meters
x = 0;
m = .25;    % kg at start
v = 0;
t = 0;
h = .000001;
max_iter = 65000000;

t_list = zeros(1,max_iter); v_list = zeros(1,max_iter);
x_list = zeros(1,max_iter); y_list = zeros(1,max_iter);
t_list(1) = t; v_list(1) = v;
x_list(1) = x; y_list(1) = y;
for k = 2:max_iter
    [x,y,v,b,m,t] = System_RK4(x,y,v,b,m,t,h);
    x_list(k)=x; y_list(k)=y;
    t_list(k)=t; v_list(k)=v;
end
figure(1)
plot(x_list,y_list,'o'); title("y over x");
figure(2)
plot(t_list,v_list,'o'); title("v over t");
figure(3)
plot(t_list,y_list,'o'); title("y over t");

% find index of impact
index = max_iter;
while y_list(index) * y_list(index-1) >= 0
    index = index-1;
end
x_list(index)
% alt.
% [p,i] = min(abs(y_list))

% find index of maximum
[m,i] = max(y_list);


% second run with halved step length
b = 2*pi*6/(360);  % degrees in radians from vertical axis
y = .1; % meters
x = 0;
m = .25;    % kg at start
v = 0;
t = 0;
h = h/2;
max_iter = max_iter * 2;

t_list2 = zeros(1,max_iter); v_list2 = zeros(1,max_iter);
x_list2 = zeros(1,max_iter); y_list2 = zeros(1,max_iter);
t_list2(1) = t; v_list2(1) = v;
x_list2(1) = x; y_list2(1) = y;
for k = 2:max_iter
    [x,y,v,b,m,t] = System_RK4(x,y,v,b,m,t,h);
    x_list2(k)=x; y_list2(k)=y;
    t_list2(k)=t; v_list2(k)=v;
end
figure(4)
plot(x_list2,y_list2,'o'); title("y over x");
figure(5)
plot(t_list2,v_list2,'o'); title("v over t");
figure(6)
plot(t_list2,y_list2,'o'); title("y over t");

% find index of impact
index2 = max_iter;
while y_list2(index2) * y_list2(index2-1) >= 0
    index2 = index2-1;
end
x_list2(index2)
% alt.
% [p,i] = min(abs(y_list))

% find index of maximum
[m,i] = max(y_list2);

% b. How far does it travel?
disp("b")
trapz(abs(v_list(1:index))*h*2)
trapz(abs(v_list2(1:index2))*h)
% trapz(v_list(1:index)*h/2)/trapz(v_list2(1:index2)*h) = .25

% c. How long is it airborn?
disp("c")
t_list(end)
t_list2(end)

% d. What was its maximum height?
disp("d")
max(y_list)
max(y_list2)

% e. What starting angle give a maximum height of 400 meters?
