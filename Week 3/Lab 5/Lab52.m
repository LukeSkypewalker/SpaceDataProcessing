%%%%%% from point ¹7
n = 200;
x1 = 5;
v1 = 1;
t = 1;
sigmaA = 0.2;
sigmaN = 20;

G = [(t^2)/2; t];
F = ([1, t; 0, 1])^6;
H = [1, 0];
P=[10000, 0; 0, 10000];

M=500;
ErrSum=zeros(1,n);
ErrSumextr=zeros(1,n);

for j=1:M
    
            a = normrnd(0,sigmaA,1,n);
        Noise = normrnd(0,sigmaN,1,n);


           X = zeros(2, n);
           Z = zeros(1, n);
           X(:, 1) = [x1; v1];
%generate the trajectory
            for i=2:n
                X(:, i) = F*X(:,i-1) + G*a(i);
                Z(i) = H*X(:,i) + Noise(i); 
            end

    
            Xk = zeros(2, n);
            for i =1:7
            Xk(:, i) = [X(1,i); X(2,i)];
            Xkextr(:, i)= [X(1,i); X(2,i)];
            end
    
    Q=sigmaA^2 * (G*G');
    
    
    for i=8:n
        P=F*P*F'+Q;
        K=P*H'/(H*P*H'+ sigmaN^2);
        Xk(:,i) = F*Xk(:, i-7);
        Xkextr(:,i)=Xk(:,i);
        Xk(:,i) = Xk(:,i)+K*(Z(i)-H*Xk(:,i));
        
        P=(eye(2)-K*H)*P;
        if j==50
        Kplot(:,i)=K;
        Pplot(i)=sqrt(P(1,1));
        end
    end
    ErrCur = ( X(1,:) - Xk(1,:) ).^2;
    ErrSum = ErrSum + ErrCur;
    
    ErrCur1 = ( Xkextr(1,:) - Xk(1,:) ).^2;
    ErrSumextr = ErrSumextr + ErrCur1;
end
%FinalError = ( ErrSum(3:end)./(M-1) ).^0.5;
FinalErrorextr= ( ErrSumextr(3:end)./(M-1) ).^0.5;
figure
hold on
%plot(FinalError);
plot(FinalErrorextr)
plot(Kplot(1,:));
% plot(Pplot)
%legend('FinalError','K','P')