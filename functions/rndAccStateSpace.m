function [ X, Measurments, A, Noise ] = rndAccStateSpace( n, sigmaA, sigmaN, x1, v1, t, F, G, H )
 
    A = normrnd(0,sigmaA,1,n);
    Noise = normrnd(0,sigmaN,1,n);

    X = zeros(2, n);
    Z = zeros(1, n);
    X(:, 1) = [x1; v1];

    for i=2:n
        X(:, i) = F*X(:,i-1) + G*A(i-1);
        Z(i) = H*X(:,i) + Noise(i); 
    end
    
end

