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

