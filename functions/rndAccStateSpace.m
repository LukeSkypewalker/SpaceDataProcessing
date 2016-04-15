function [ X, Measurments, Acc, Noise ] = rndAccStateSpace( n, sigmaA, sigmaN, x1, v1, t )
 
    a = normrnd(0,sigmaA,1,n);
    Noise = normrnd(0,sigmaN,1,n);

    G = [(t^2)/2; t];
    F = [1, t; 0, 1];
    H = [1, 0];

    X = zeros(2, n);
    Z = zeros(1, n);
    X(:, 1) = [x1; v1];

    for i=2:n
        X(:, i) = F*X(:,i-1) + G*a(i);
        Z(i) = H*X(:,i) + Noise(i); 
    end
    
end

