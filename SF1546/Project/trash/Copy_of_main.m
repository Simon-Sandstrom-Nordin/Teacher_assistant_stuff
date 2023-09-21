clc; clear all; close all;

% a. Where does it land? (measured horizontally from the starting point)
% starting conditions
% first run
b = 2*pi*6/(360);  % degrees in radians from vertical axis
y = .1; % meters
x = 0;
m = .25;    % kg at start
v = 0;
t = 0;

h = .0000000000001;
t_list_first = []; v_list_first = [];
x_list_first = []; y_list_first = [];
t_list_first(1) = t; v_list_first(1) = v;
x_list_first(1) = x; y_list_first(1) = y;
while v_list_first(end) < 10^(-6)
    [x,y,v,b,m,t] = System_RK4(x,y,v,b,m,t,h);
    x_list_first(end+1)=x; y_list_first(end+1)=y;
    t_list_first(end+1)=t; v_list_first(end+1)=v;
end

h = .001;
max_iter = 65000;
t_list_append = zeros(1,max_iter); v_list_append = zeros(1,max_iter);
x_list_append = zeros(1,max_iter); y_list_append = zeros(1,max_iter);
t_list = [t_list_first, t_list_append]; v_list = [v_list_first, v_list_append];
x_list = [x_list_first, x_list_append]; y_list = [y_list_first, y_list_append];
for k = 1:max_iter
    [x,y,v,b,m,t] = System_RK4(x,y,v,b,m,t,h);
    x_list(length(x_list_first)+k)=x; y_list(length(y_list_first)+k)=y;
    t_list(length(t_list_first)+k)=t; v_list(length(v_list_first)+k)=v;
end
figure(1)
plot(x_list(length(x_list_first)+1:length(x_list)),y_list(length(y_list_first)+1:length(y_list)),'o'); title("y over x");
figure(2)
plot(v_list(length(v_list_first)+1:length(v_list)),t_list(length(t_list_first)+1:length(t_list)),'o'); title("v over t");
figure(3)
plot(y_list(length(y_list_first)+1:length(y_list)),t_list(length(t_list_first)+1:length(t_list)),'o'); title("y over t");

% find index of impact
index = max_iter;
while y_list(index) * y_list(index-1) >= 0
    index = index-1;
end
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

h = .0000000000001;
t_list_first = []; v_list_first = [];
x_list_first = []; y_list_first = [];
t_list_first(1) = t; v_list_first(1) = v;
x_list_first(1) = x; y_list_first(1) = y;
while v_list_first(end) < 10^(-6)
    [x,y,v,b,m,t] = System_RK4(x,y,v,b,m,t,h);
    x_list_first(end+1)=x; y_list_first(end+1)=y;
    t_list_first(end+1)=t; v_list_first(end+1)=v;
end

h = .001/2;
max_iter = 65000*2;
t_list_append = zeros(1,max_iter); v_list_append = zeros(1,max_iter);
x_list_append = zeros(1,max_iter); y_list_append = zeros(1,max_iter);
t_list = [t_list_first, t_list_append]; v_list = [v_list_first, v_list_append];
x_list = [x_list_first, x_list_append]; y_list = [y_list_first, y_list_append];
for k = 1:max_iter
    [x,y,v,b,m,t] = System_RK4(x,y,v,b,m,t,h);
    x_list(length(x_list_first)+k)=x; y_list(length(y_list_first)+k)=y;
    t_list(length(t_list_first)+k)=t; v_list(length(v_list_first)+k)=v;
end
figure(4)
plot(x_list(length(x_list_first)+1:length(x_list)),y_list(length(y_list_first)+1:length(y_list)),'o'); title("y over x");
figure(5)
plot(v_list(length(v_list_first)+1:length(v_list)),t_list(length(t_list_first)+1:length(t_list)),'o'); title("v over t");
figure(6)
plot(y_list(length(y_list_first)+1:length(y_list)),t_list(length(t_list_first)+1:length(t_list)),'o'); title("y over t");

% find index of impact
index = max_iter;
while y_list(index) * y_list(index-1) >= 0
    index = index-1;
end
% alt.
% [p,i] = min(abs(y_list))

% find index of maximum
%[m,i] = max(y_list);
% alt.
% [p,i] = min(abs(y_list))

% find index of maximum
% [m,i] = max(y_list2);

% b. How far does it travel?
%trapz(v_list2(1:index)*h/2)
%trapz(v_list2(1:index2)*h)
% trapz(v_list(1:index)*h/2)/trapz(v_list2(1:index2)*h) = .25

% c. How long is it airborn?

% d. What was its maximum height?

% e. What starting angle give a maximum height of 400 meters?
