function [ Xk ] = kalman( sigmaA, sigmaN, F, G, H)
    Xk = zeros(2, n);
    Xk(:, 1) = [x1; v1];

    Q=sigmaA^2 * (G*G');
    P=[10000, 0; 0, 10000];

    for i=2:n
        P=F*P*F'+Q;
        K=P*H'/(H*P*H'+ sigmaN^2);
        Xk(:,i) = F*Xk(:, i-1);
        Xk(:,i) = Xk(:,i)+K*(Z(i)-H*Xk(:,i));
        P=(eye(2)-K*H)*P;
    end

end

