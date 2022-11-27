% Domo.

clc; clear; close all; format long;
x0=0; L=3.6;
T0=315; TN=445;
temp_vector=[];
for i=0:1
    N = 360 * (2^i);
    %N=24*(2^i);
    
    x=linspace(x0,L,N+1);
    xvector=x';
    h=(L-x0)/N;
    k=@(x) 2+(x./3);

    alpha=(2.*(k(x(2:N))))./(h^2); 
    beta=(-1/(6*h))-((k(x(2:N-1)))./(h^2));
    gamma=(1/(6*h))-((k(x(3:N)))./(h^2));
    A=diag(alpha,0)+diag(beta,1)+diag(gamma,-1);

    Q=@(x) 280.*exp(-(x-(L/2)).^2);
    b=zeros(N-1,1);
    b(1)=Q(x(2))-(((1/(6*h))-(k(x(2))/(h^2)))*T0);
    b(2:N-2)=Q(x(3:N-1));
    b(N-1)=Q(x(N))-((-(1/(6*h))-(k(x(N)))/(h^2))*TN);

    Tmiddle=A\b;
    Temp=[T0; Tmiddle; TN];
    temp_vector=[temp_vector; Temp((3.12/h)+1)];
end
figure(9)
plot(x,Temp)
temp_vector
