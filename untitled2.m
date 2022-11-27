%% Uppgift 5 b)
% There are three roots here
Ivec=[];
for k=60:1:100;
    f=@(x) exp(0.5.*((k.*x)./(3.*k+x)));
    I=integral(f,1,4*k,'RelTol',1e-8);
    Ivec=[Ivec;I(end)];
end
Ivec;
k=60:1:100;
figure(15)
plot(k,Ivec,'c')
g= @(k) 7.*((2-k).^4);
hold on
plot(k,g(k))

% d)
kvalue=fzero(@integ,35)

