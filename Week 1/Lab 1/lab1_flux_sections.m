%% Lab-1: Relationship between solar radio flux F10.7 and sunspot number
% Team1: Dmitry Shadrin and Eugenii Israelit, Skoltech, 29.03.2016 v1
% Space Data Processing, Professor: Tatiana Podladchikova

%% Prepare Data
clc; clear; close all;

Data = importdata('data_group1.mat');
SunSpot = Data(:,5);
Flux = Data(:,4);

% Convert Time to Years (for displaying in Plots)
Time = (Data(:,3)-717428)./365 + 1964;

%% 13-month running mean
SunSpotSmooth = smooth(SunSpot);
FluxSmooth = smooth(Flux);

figure, plot(Time, SunSpot, Time, SunSpotSmooth);
title('SunSpot and SunSpotSmooth');
xlabel('time'), ylabel('SunSpot');
legend('SunSpot', 'SunSpotSmooth');

figure, plot(Time, Flux, Time, FluxSmooth);
title('Flux and FluxSmooth');
xlabel('time'), ylabel('Flux');
legend('Flux', 'FluxSmooth');

%% Correlation between SunSpots and Flux
figure, scatter(SunSpot, Flux);
title('Correlation between SunSpots and Flux');
xlabel('SunSpot'), ylabel('Flux');

figure, scatter(SunSpotSmooth, FluxSmooth);
title('Correlation between SunSpotsSmooth and FluxSmooth');
xlabel('SunSpotSmooth'), ylabel('FluxSmooth');

%% Reconstruct solar radio flux on the basis of sunspot number 
fluxCalc = calculateFlux(SunSpotSmooth,FluxSmooth); 

figure, plot(Time, fluxCalc, Time, FluxSmooth);
title('FluxCalc VS FluxSmooth');
xlabel('time'), ylabel('flux');
legend('FluxCalc', 'FluxSmooth');

%% The variance of estimation error of solar ratio flux at 10.7
var(FluxSmooth-fluxCalc)



