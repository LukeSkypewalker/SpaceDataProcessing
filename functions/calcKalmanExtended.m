function [ Xk ] = calcKalmanExtended(Z, Z0, F, P, Q, R )
  
    n = length(Z(1,:));
    Xk = zeros(4, n);
    Xk(:, 1) = Z0;
    
    for i=2:n
        
        Xk(:,i) = F*Xk(:, i-1);
        P1 = F*P*F'+Q;
        
        sqr = sqrt(Xk(1,i)^2+Xk(3,i)^2) ;
        H = [ sqr ; atan(Xk(1,i)/Xk(3,i)) ]; 
        dH = [  Xk(1,i)/sqr  0 Xk(3,i)/sqr  0; 
                Xk(3,i)/(sqr^2) 0 -Xk(1,i)/(sqr^2)  0 ];
        
        K = P1 * dH' * inv(dH * P * dH' + R);   
        Xk(:,i) = Xk(:,i) + K*(Z(:,i) - H);
        P = (eye(4)-K*dH) * P1;
      
    end

end

