function [Xk,Dmextr,Dmfiltr,Bmextr,Bmfiltr] = calcKalmanExtended(Z,Z0, F, P, Q, R )
  
    n = length(Z(1,:));
   
    Xk = zeros(4, n);
    Xk(:, 1) = Z0;

    Dmextr=zeros(1,n);
    Dmfiltr=zeros(1,n);
    Bmextr=zeros(1,n);
    Bmfiltr=zeros(1,n);
  
   
 
    
    for i=2:n

        P=F*P*F'+Q;
        Xk(:,i) = F*Xk(:, i-1);
        
        
        sqr=sqrt(Xk(1,i)^2+Xk(3,i)^2);
        H=[sqr;atan(Xk(1,i)/Xk(3,i))];
        dH=[Xk(1,i)/sqr 0 Xk(3,i)/sqr 0; Xk(3,i)/(sqr^2) 0 -Xk(1,i)/(sqr^2) 0];
        
        Dmextr(i)=sqrt(Xk(1,i)^2+Xk(3,i)^2);
        Bmextr(i)=atan(Xk(1,i)/Xk(3,i));
         
        K=P*dH'*inv((dH*P*dH'+R));
        
        
        
        Xk(:,i) = Xk(:,i)+K*(Z(:,i)-H);
        
        
        Dmfiltr(i)=sqrt(Xk(1,i)^2+Xk(3,i)^2);
        Bmfiltr(i)=atan(Xk(1,i)/Xk(3,i));
        
        P = (eye(4)-K*dH)*P;
      
    end

end
