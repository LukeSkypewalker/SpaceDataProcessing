function [ X, Measurments  ] = calcTrajectory( Acc, Noise, x1, v1, t)
    
    n=length(Acc);
    X(n) = zeros();
    X(1) = x1;
    Vel(n) = zeros();
    Vel(1) = v1;

    for i = 2:n
        Vel(i) = Vel(i-1) + Acc(i-1)*t;
        X(i) = X(i-1) + Vel(i-1)*t + (Acc(i-1)*t^2)/2;
    end

    Measurments = X + Noise;

end





function [ Xk, SigmaX ] = calcKalman(Z, sigmaA, sigmaN, x1, v1, F, G, H, P, bias )
  
    n=length(Z);
   
    Xk = zeros(2, n);
    Xk(:, 1) = [x1; v1];

    Q=sigmaA^2 * (G*G');
   
    SigmaX = zeros(1,n);
    SigmaX(1) = sqrt(P(1,1));
    
    for i=2:n
        P=F*P*F'+Q;
        K=P*H'/(H*P*H'+ sigmaN^2);
        Xk(:,i) = F*Xk(:, i-1) + G*bias;
        Xk(:,i) = Xk(:,i)+K*(Z(i)-H*Xk(:,i));

        P = (eye(2)-K*H)*P;
        SigmaX(i) = sqrt(P(1,1));
    end

end








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


