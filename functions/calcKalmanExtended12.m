function [ Xk ] = calcKalmanExtended12(Z, Z0, F, P, Q, R )
  
    n = length(Z(1,:));
    Xk = zeros(4, n);
    Xk(:, 1) = Z0;
    
    for i=4:n
        
        Xk(:,i) = F*Xk(:, i-1);
        P = F*P*F'+Q;
        
            
        if mod(i,2)==0
            sq = (Xk(1,i)^2+Xk(3,i)^2) ;
            H = atan(Xk(1,i)/Xk(3,i)) ; 
            dH = [ Xk(3,i)/sq 0 -Xk(1,i)/sq 0 ];
        else
            sqr = sqrt(Xk(1,i)^2+Xk(3,i)^2) ;
            H = [ sqr ; atan(Xk(1,i)/Xk(3,i)) ];
            dH = [  Xk(1,i)/sqr  0 Xk(3,i)/sqr  0; 
                    Xk(3,i)/(sqr^2) 0 -Xk(1,i)/(sqr^2)  0 ];
        
        end
        
        K = P * dH' * inv(dH * P * dH' + R);   
        Xk(:,i) = Xk(:,i) + K*(Z(:,i) - H);
        P = (eye(4)-K*dH) * P;
        
    end

end

