function [ Xk,Dmextr,Dmfiltr,Bmextr,Bmfiltr, R] = calcKalman4(Z, sigmaA, sigmaD, sigmaB, Dm, Bm, F, G, H, P, bias )
  
    n = length(Z(1,:));
   
    Xk = zeros(4, n);
    Xk(:, 1) = [40000; -20; 40000; -20];
    Dmextr=zeros(1,n);
    Dmfiltr=zeros(1,n);
    Bmextr=zeros(1,n);
    Bmfiltr=zeros(1,n);
    
    Q = sigmaA * (G*G');
   
 
    
    for i=2:n
        P=F*P*F'+Q;
        R(2,2)=zeros();
        
        R(1,1)=(sigmaD^2)*(sin(Bm(i)))^2+(Dm(i)^2)*(sigmaB^2)*(cos(Bm(i)))^2 ;
        R(1,2)=sin(Bm(i))*cos(Bm(i))*((sigmaD^2)-(Dm(i)^2)*(sigmaB^2));
        R(2,1)=sin(Bm(i))*cos(Bm(i))*((sigmaD^2)-(Dm(i)^2)*(sigmaB^2));
        R(2,2)=(sigmaD^2)*(cos(Bm(i)))^2+(Dm(i)^2)*(sigmaB^2)*(sin(Bm(i)))^2;
        
        K=P*H'*inv((H*P*H'+R));
        
        Xk(:,i) = F*Xk(:, i-1) + G*bias;
        
        Dmextr(i)=sqrt(Xk(1,i)^2+Xk(3,i)^2);
        Bmextr(i)=atan(Xk(1,i)/Xk(3,i));
        
        Xk(:,i) = Xk(:,i)+K*(Z(:,i)-H*Xk(:,i));
        
        Dmfiltr(i)=sqrt(Xk(1,i)^2+Xk(3,i)^2);
        Bmfiltr(i)=atan(Xk(1,i)/Xk(3,i));
        P = (eye(4)-K*H)*P;
      
    end

end

