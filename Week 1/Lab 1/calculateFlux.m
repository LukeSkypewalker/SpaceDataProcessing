function FluxCalc = calculateFlux(SunSpotSmooth,FluxSmooth)

len = length(SunSpotSmooth);

F = FluxSmooth';
S = SunSpotSmooth'; 
R = [ones(len, 1) S S.^2 S.^3];

% Determine vector of coefficients
B=((R'*R)\R')*F; 

FluxCalc = B(1) + B(2)*SunSpotSmooth + B(3)*SunSpotSmooth.^2 +B(4)*SunSpotSmooth.^3;