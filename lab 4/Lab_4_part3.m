clc
clear all
close all
data=importdata('data_group1.mat') %uploading file with data


sunSpot= data(:,5)'; %rearrenge data to colomns for more convenience
flux= data(:,4)';
Time = (data(:,3)-717428)./365 + 1964;

m=13;
SmoothSunSpot=smooth(sunSpot, m);
SmoothFlux=smooth(flux,m);

ndots=100; %number of alphas
Idespot(ndots)=zeros();
Ivespot(ndots)=zeros();
Ideflux(ndots)=zeros();
Iveflux(ndots)=zeros();
Alpha(ndots)=zeros();

for i=1:ndots

    alpha=0.99-i/(ndots+10); %guessing optimal alpha 10 is needed to avoid negative alphas

    [XExpSpot, XExpBSpot]=expsmooth(sunSpot,alpha); %function for exponential smoothing
    [XExpFlux, XExpBFlux]=expsmooth(flux,alpha);
    

    [idmspot, idespot, ivmspot, ivespot] = smoothind(XExpBSpot,SmoothSunSpot,sunSpot); %function for discrepancies
    [idmflux, ideflux, ivmflux, iveflux] = smoothind(XExpBFlux,SmoothFlux,flux);
Idespot(i)=idespot;
Ivespot(i)=ivespot;
Ideflux(i)=ideflux;
Iveflux(i)=iveflux;
Alpha(i)=alpha;
end


figure; plot(Alpha,Idespot)
hold on
plot(Alpha,Ivespot,'red')
title('Exponential smoothing Sunspot')
legend('deviation indicator sunspot','variation indicator sunspot')
xlabel('alpha')

figure; plot(Alpha,Ideflux)
hold on
plot(Alpha,Iveflux,'red')
title('Exponential smoothing Flux')
legend('deviation indicator flux','variation indicator flux')
xlabel('alpha')

alpha=0.62;
[XExpSpot, XExpBSpot]=expsmooth(sunSpot,alpha);
[XExpFlux, XExpBFlux]=expsmooth(flux,alpha);

figure; plot(sunSpot)
hold on
plot(SmoothSunSpot,'red')
plot(XExpBSpot,'green')
title('Running mean & exponential smoothing of sunspot')
legend('sunspot monthly mean','Running mean m=13','exp smoothing, alpha=0,62')
xlabel('step')

figure; plot(flux)
hold on
plot(SmoothFlux,'red')
plot(XExpBFlux,'green')
title('Running mean & exponential smoothing of flux')
legend('flux monthly mean','Running mean m=13','exp smoothing, alpha=0,62')
xlabel('step')
