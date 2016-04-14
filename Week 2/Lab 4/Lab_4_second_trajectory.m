%Determining and removing drawbacks of exponential and running mean
%Eugenii Israelit,Dmitry Shadrin,Skoltech, 2016

clc
clear all
close all

n=200;
t=32;

X(n)=zeros();
A(n)=zeros();
Z(n)=zeros();

W=normrnd(0,0.08,1,n);
N=normrnd(0,0.05,1,n);

w=2*pi()/t;
A(1)=1;
%generating an oscilations
for i=2:n
    A(i)=A(i-1)+W(i);
    X(i)=A(i)*sin(w*i+3);
end

Z=X+N;

m=13;
SmoothX=smooth(Z,m);

plot(Z)
hold on
plot(SmoothX,'red')
legend('measurements','running mean smooth m=15')
xlabel('amplitude')
ylabel('step')

% t should be guessed.... 8a) approx t=12 8b) approx t=5 8c) approx t=40
