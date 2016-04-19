function [ Arr ] = gaussMarkov( n, sigmaA, sigmaXi, lambda, t )
    
    sigmaZeta = sqrt(1-exp(-2*lambda*t));
    Zeta = sigmaZeta * sigmaA * normrnd(0, sigmaXi, 1, n);

    Arr = zeros(1,n);
    Arr(1)= normrnd(0, sigmaA);

    correlKoef = exp(-lambda*t);

    for i=2:n
        Arr(i) = correlKoef * Arr(i-1) + Zeta(i);
    end

end

