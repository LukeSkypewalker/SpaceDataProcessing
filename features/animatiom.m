clc; clear; close all;
addpath('../functions/');

n=50;
alpha1=0.2;
alpha2=0.5;
alpha3=0.8;

A = normrnd(0,sqrt(100),1,n);
N = normrnd(0,sqrt(100),1,n);

Z(n) = zeros();
X(n) = zeros();
V(n) = zeros();
E1(n) = zeros();
E2(n) = zeros();
E3(n) = zeros();
X(1) = 5;
V(1) = 0;
Z(1) = X(1)+N(1); 
E1(1) = Z(1);
E2(1) = Z(1);
E3(1) = Z(1);
t = 0.1;

figure; 

for i=2:n
    V(i)=V(i-1) + A(i)*t;
    X(i)=X(i-1) + V(i)*t + (A(i)*t^2)/2;    
    Z(i)=X(i)+N(i);
    E1(i)=E1(i-1)*alpha1 +Z(i)*(1-alpha1);
    E2(i)=E2(i-1)*alpha2 +Z(i)*(1-alpha2);
    E3(i)=E3(i-1)*alpha3 +Z(i)*(1-alpha3);
    
    subplot(2,1,1);
    
    plot(X(1:i),'red');
    hold on
%     axis([0 n -n/2 n/2]);
    
    
%     subplot(2,1,2);
    plot(Z(1:i),'yellow');
%     axis([0 n -n/2 n/2]);
    
    plot(E1(1:i),'blue');
    plot(E2(1:i),'black');
    plot(E3(1:i),'green');
    axis([0 n -n/2 n/2]);
    
    pause(1/30);
end

