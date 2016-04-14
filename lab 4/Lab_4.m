%Determining and removing drawbacks of exponential and running mean
%Eugenii Israelit,Dmitry Shadrin,Skoltech, 2016
clc
clear all
close all

n=300;

A=normrnd(0,sqrt(10),1,n); 
N=normrnd(0,sqrt(500),1,n);

X(n)=zeros();
V(n)=zeros();
Z(n)=zeros();
t=0.1;

X(1)=5;
V(1)=0;
% generating of the trajectory
for i=2:n
V(i)=V(i-1)+A(i)*t;
X(i)=X(i-1)+V(i)*t+A(i)*((t^2)/2);
end

Z=X+N; %measurements generating

ndots=100; %number of alphas and m 
Idm(ndots)=zeros(); %massives for deviations
Ide(ndots)=zeros();
Ivm(ndots)=zeros();
Ive(ndots)=zeros();
M(ndots)=zeros();
Alpha(ndots)=zeros();

for i=1:ndots

    alpha=0.99-i/(ndots+10); %guessing optimal alpha by calculating deviations with different alpha
    m=floor(1+i*(n/(2*ndots))); %guessing optimal window size M by calculating deviations with different m; 2 means that maximum half of whole measurements would be taken

    [XExp, XExpB]=expsmooth(Z,alpha); %function for exponential smoothing

    SmoothX=smooth(Z,m); %function for running mean

    [idm, ide, ivm, ive] = smoothind(XExp,SmoothX,Z); %function for discrepancies
    
Idm(i)=idm; %putting current deviations into massives
Ide(i)=ide;
Ivm(i)=ivm;
Ive(i)=ive;

M(i)=m;%putting current window size into massive
Alpha(i)=alpha; %putting current alpha size into massive
end

figure; plot(M,Idm)
hold on
plot(M,Ivm,'red')
title('Running mean smoothing')
legend('deviation indicator','variability indicator')
xlabel('window size M')

figure; plot(Alpha,Ide)
hold on
plot(Alpha,Ive,'red')
title('Exponential smoothing')
legend('deviation indicator','variability indicator')
xlabel('alpha')

%calculation and plotting of running mean smoothing and exponential smoothing for the best m and alpha
m=25;
alpha=0.4;
[XExp, XExpB]=expsmooth(Z,alpha);
SmoothX=smooth(Z,m);

figure; plot(X)
hold on
plot(Z,'red')
plot(SmoothX,'green')
plot(XExp,'k')
title('true tajectory, measurements & smoothing');
legend('true trajectory, X','measurements, Z','running mean smoothing','exponential smoothing')
xlabel('step number');
ylabel('coordinate');

