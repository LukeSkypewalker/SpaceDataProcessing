function [ Xk, Dmextr,Dmfiltr,Bmextr,Bmfiltr ] = calcKalmanExtended12(Z, Z0, F, P, Q, R1, R2 )
  
    n = length(Z(1,:));
    Xk = zeros(4, n);
    Xk(:, 3) = Z0;
    
    Dmextr=zeros(1,n-3);
    Dmfiltr=zeros(1,n-3);
    Bmextr=zeros(1,n-3);
    Bmfiltr=zeros(1,n-3);
    
    for i=4:n
        
        Xk(:,i) = F*Xk(:, i-1);
        P = F*P*F'+Q;
        
        Dmextr(i)=sqrt(Xk(1,i)^2+Xk(3,i)^2);
        Bmextr(i)=atan(Xk(1,i)/Xk(3,i));
        
        if mod(i,2)==0
            sq = (Xk(1,i)^2+Xk(3,i)^2) ;
            H = atan(Xk(1,i)/Xk(3,i)) ; 
            dH = [ Xk(3,i)/sq 0 -Xk(1,i)/sq 0 ];
            K = P * dH' * inv(dH * P * dH' + R2);   
            Xk(:,i) = Xk(:,i) + K*(Z(2,i) - H);
        else
            sqr = sqrt(Xk(1,i)^2+Xk(3,i)^2) ;
            H = [ sqr ; atan(Xk(1,i)/Xk(3,i)) ];
            dH = [  Xk(1,i)/sqr  0 Xk(3,i)/sqr  0; 
                    Xk(3,i)/(sqr^2) 0 -Xk(1,i)/(sqr^2)  0 ];
            K = P * dH' * inv(dH * P * dH' + R1);   
            Xk(:,i) = Xk(:,i) + K*(Z(:,i) - H);
        end
        
        Dmfiltr(i)=sqrt(Xk(1,i)^2+Xk(3,i)^2);
        Bmfiltr(i)=atan(Xk(1,i)/Xk(3,i));
        
        P = (eye(4)-K*dH) * P;
        
    end

end

