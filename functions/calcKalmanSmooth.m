function [ Xk, SigmaX, PiN ] = calcKalmanSmooth(Z, sigmaA, sigmaN, x1, v1, F, G, H, P, bias )
  
    n=length(Z);
   
    Xk = zeros(3, n);
    Xk(:, 1) = [2; 0; 0];

    Q=sigmaA * (G*G');
    Ak=cell(1,200);
    PiN=cell(1,200);
    Ppredict=cell(1,200);
    Pfiltrate=cell(1,200);
        Pfiltrate(1)={P};
        Ppredict(1)={P};
    SigmaX = zeros(3,n);
    SigmaX(1,1) = sqrt(P(1,1));
    SigmaX(2,1) = sqrt(P(2,2));
    SigmaX(3,1) = sqrt(P(3,3));
    
    for i=2:n
        P=F*P*F'+Q;
        Ppredict(i)={P};
        K=P*H'/(H*P*H'+ sigmaN^2);
        Xk(:,i) = F*Xk(:, i-1) + G*bias;
        Xk(:,i) = Xk(:,i)+K*(Z(i)-H*Xk(:,i));

        P = (eye(3)-K*H)*P;
        Pfiltrate(i)={P};
        
        SigmaX(1,i) = sqrt(P(1,1));
        SigmaX(2,i) = sqrt(P(2,2));
        SigmaX(3,i) = sqrt(P(3,3));
    end

    Xks(:,n)=Xk(:,n); 
    PiN{n}=Pfiltrate{n};
   for i=n-1:-1:1
       P1=Ppredict{i};
       P2=Pfiltrate{i};
           Ak(i)={P2*F'*(inv(P1))};
         
            PiN(i)={Pfiltrate{(i)}+Ak{(i)}*(PiN{(i+1)}-Ppredict{(i)})*(Ak{(i)}')};
            Xks(:,i)=Xk(:,i)+Ak{(i)}*(Xks(:,i+1)-F*Xk(:,i));
    end
        

