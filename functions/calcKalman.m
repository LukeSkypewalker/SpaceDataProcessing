function [ X, Xk, SigmaX ] = calcKalman( n, sigmaA, sigmaN, x1, v1, t, q )
  
    a = normrnd(0,sigmaA,1,n)+0.2;
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

    Xk = zeros(2, n);
    Xk(:, 1) = [x1; v1];

    Q=sigmaA^2 * (G*G');
    P=[10000, 0; 0, 10000];
    SigmaX = zeros(1,n);
    SigmaX(1) = P(1,1);
    
    for i=2:n
        P=F*P*F'+Q;
        K=P*H'/(H*P*H'+ sigmaN^2);
        Xk(:,i) = F*Xk(:, i-1) + G*q;
        Xk(:,i) = Xk(:,i)+K*(Z(i)-H*Xk(:,i));

        P = (eye(2)-K*H)*P;
        SigmaX(i) = sqrt(P(1,1));
    end

end

