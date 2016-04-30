%% Lab-1: Relationship between solar radio flux F10.7 and sunspot number
% Team1: Dmitry Shadrin and Eugenii Israelit, Skoltech, 29.03.2016 v1
clc; clear; close all;

Data = importdata('data_group1.mat');
SunSpot = Data(:,5);
Flux = Data(:,4);

% 13-month running mean
SunSpotSmooth = smooth(SunSpot);
FluxSmooth = smooth(Flux);

% Reconstruct solar radio flux on the basis of sunspot number 
FluxCalc = calculateFlux(SunSpotSmooth,FluxSmooth); 

% The variance of estimation error of solar ratio flux at 10.7
var(FluxSmooth-FluxCalc)



%% ---Graphs-----------------------------

% Convert Time to Years (for displaying in Plots)
Time = (Data(:,3)-717428)./365 + 1964;

figure, plot(Time, SunSpot, Time, SunSpotSmooth);
title('SunSpot and SunSpotSmooth');
xlabel('time'), ylabel('SunSpot');
legend('SunSpot', 'SunSpotSmooth');

% figure, plot(Time, Flux, Time, FluxSmooth);
% title('Flux and FluxSmooth');
% xlabel('time'), ylabel('Flux');
% legend('Flux', 'FluxSmooth');
% 
% figure, plot (Time, SunSpot, Time, Flux);
% title ('Dependence of smoothing monthly mean sunspot number & solar radio flux F10.7cm on Time');
% legend('sunSpot','flux, sfu');
% xlabel('Time, years');
% 
% figure, plot (Time, SunSpotSmooth, Time, FluxSmooth);
% title ('Dependence of smoothing monthly mean sunspot number & solar radio flux F10.7cm on Time');
% legend('sunSpotSmooth','fluxSmooth, sfu');
% xlabel('Time, years');
% 
% figure, scatter(SunSpot, Flux), xlabel('sun'), ylabel('flux');
% title('Correlation between SunSpots and Flux');
% xlabel('SunSpot'), ylabel('Flux');
% 
% figure, scatter(SunSpotSmooth, FluxSmooth), xlabel('sunSmooth'), ylabel('fluxSmooth');
% title('Correlation between SunSpotsSmooth and FluxSmooth');
% xlabel('SunSpotSmooth'), ylabel('FluxSmooth');
% 
% figure, plot(Time, FluxCalc, Time, FluxSmooth);
% title('FluxCalc VS FluxSmooth');
% xlabel('time'), ylabel('flux');
% legend('FluxCalc', 'FluxSmooth');
% 
% figure, scatter(SunSpotSmooth, FluxSmooth);
% hold, scatter ( SunSpotSmooth, FluxCalc);
% title ('Monthly mean sunspot number & solar radio flux F10.7cm');
% legend ('smoothed flux', 'calculated flux');
% xlabel('sunSpot'), ylabel('F10.7, sfu');
% 
