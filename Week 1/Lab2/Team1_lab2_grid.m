%% Lab-2: Converting a physical distance to a grid distance using least-square method 
% Team1: Dmitry Shadrin and Eugenii Israelit, Skoltech, 01.04.2016 v1

%% Prepare Data
clc; clear; close all;
KSI = importdata('data for lab\group1\ksi2_N_100_sigma_7_L1_1000_delta_10.mat');
% KSI = importdata('data for lab\group1\ksi1_N_100_000_sigma_7_L1_1000_delta_10.mat');

%% Determine unknown vector X
n = length(KSI);

W = [ n          (n-1)*n/2          ; 
     (n-1)*n/2   (n-1)*n*(2*n-1)/6 ];

C = [ sum(KSI); 
      sum(KSI.*((1:n) - 1)) ];

X = W \ C;

%% Determine the covariance matrix of estimation error of vector X
L = X(1)+(0:n-1)*X(2);
varX = sum((KSI - L).^2) / (n - 2);
covX = varX .* inv(W);
