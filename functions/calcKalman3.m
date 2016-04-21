function [ Xk, SigmaX ] = calcKalman3(Z, sigmaA, sigmaN, x1, v1, F, G, H, P, bias )
  
    n = length(Z);
   
    Xk = zeros(3, n);
    Xk(:, 1) = [2; 0; 0];

    Q = sigmaA * (G*G');
   
    SigmaX = zeros(3,n);
    SigmaX(1,1) = sqrt(P(1,1));
    SigmaX(2,1) = sqrt(P(2,2));
    SigmaX(3,1) = sqrt(P(3,3));
    
    for i=2:n
        P=F*P*F'+Q;
        K=P*H'/(H*P*H'+ sigmaN^2);
        Xk(:,i) = F*Xk(:, i-1) + G*bias;
        Xk(:,i) = Xk(:,i)+K*(Z(i)-H*Xk(:,i));

        P = (eye(3)-K*H)*P;
        SigmaX(1,i) = P(1,1)^(1/2) ;
        SigmaX(2,i) = P(2,2)^(1/2) ;
        SigmaX(3,i) = P(3,3)^(1/2) ;
    end

end

