function [ X, Z ] = calcAccStateSpace( A, Noise, x1, v1, F, G, H )
 
    n=length(A);
    X = zeros(2, n);
    Z = zeros(1, n);
    X(:, 1) = [x1; v1];

    for i=2:n
        X(:, i) = F*X(:,i-1) + G*A(i-1);
        Z(i) = H*X(:,i) + Noise(i); 
    end
    
end

