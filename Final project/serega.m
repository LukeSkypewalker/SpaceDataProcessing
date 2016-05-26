clc
clear all
close all

%_______________________SPACE DATA PROCESSING 2016_______________________%

%_____________________________Final Project______________________________%
%______________EXTRACTION OF A USEFUL SIGNAL FROM NOISY DATA_____________%
%__Group 3:Carolina Moreno, Andrew Lamb, Sergey Golovanov, Vishal Vasu___%
%________________________________Skoltech________________________________%


%_________________________________PART 2_________________________________% 
%_______TRACKING AND FORECASTING IN CONDITIONS OF MEASUREMENT GAPS_______%

%_TASK 1:KALMAN FILTER(NORMALLY DISTRIBUTED UNBIASED RANDOM ACCELERATION_%

%_______1-1:Generate true trajectory of an object motion disturbed_______%
%________________by normally unbiased random acceleration________________%

n=200; %observation interval
sigmasqalpha=0.2^2;
X=zeros(1,n);
X(1)=5;
V=zeros(1,n);
V(1)=1;
T=1;
a=normrnd(0,sqrt(sigmasqalpha),1,n);

for i=2:n
    V(i)=V(i-1)+a(i-1)*T;
    X(i)=X(i-1)+V(i-1)*T+(a(i-1)*T^2)/2;
end

%______________1-2:Generate measurements of the coordinate_______________%
sigmasqN = 20^2; %variance of measurement
etha=normrnd(0,sqrt(sigmasqN),1,n);
z=zeros(1,n);
for i=1:n
    z(i)=X(i)+etha(i);
end

%     figure;
%     plot(X,'b')
%     hold on
%     plot(z,'g')
%     title('True trajectory of an object motion disturbed by a normally distributed unbiased acceleration')
%     legend('Trajectory','Measurements');
%     xlabel('Time step')
%     ylabel('Estimation of coordinate')

%_______________1-3:Kalman filter algorithm(unbiased noise)______________%
F=[1 T;0 1];    %transition matrix
G=[(T^2)/2;T];  %input matrix
H=[1 0];        %observation matrix    %%%%%%%puede cambiar si necesitamos calcular V%%%%%%

X1=zeros(2,n);
X1(:,1)=[X(1);V(1)];
z1=zeros(1,n);
for i=2:n
    X1(:,i)=F*X1(:,i-1)+G*a(i); %State equation
    z1(i)=H*X1(:,i)+etha(i); %Measurement equation
end
P=0.2; %measurement with gap
gap=rand(1,n);
z1(gap<=P)=NaN;

Xf=zeros(2,n); 
Xf(:,1)=[2;0];  %state vector
Pf=zeros(2,2,n);
Pf(:,:,1)=[10000 0;0 10000]; %initial filtration error covariance matrix
Q=G*G'*sigmasqalpha;
R=sigmasqN;
Xp=zeros(2,n);
Pp=zeros(2,2,n);
K=zeros(2,n);
for i=2:n    
    % Filtration if measurements are available
    if isnan(z1(i))~=1 
        Xp(:,i)=F*Xf(:,i-1); %prediction of state vector(extrapolation)
        Pp(:,:,i)=F*Pf(:,:,i-1)*F'+Q; %prediction error covariance matrix(extrapolation)
        K(:,i)=(Pp(:,:,i)*H')/(H*Pp(:,:,i)*H'+R); %filter gain(filtration)
        Pf(:,:,i)=(eye(2)-K(:,i)*H)*Pp(:,:,i); %filtration error covariance matrix(filtration)
        Xf(:,i)=Xp(:,i)+(K(:,i)*(z1(:,i)-H*Xp(:,i))); %improved estimate(filtration)
    end
    
    % Filtration if measurements are not available
    if isnan(z1(i))==1 
        Xp(:,i)=F*Xf(:,i-1); %prediction of state vector(extrapolation)
        Pp(:,:,i)=F*Pf(:,:,i-1)*F'+Q; %prediction error covariance matrix(extrapolation)
        K(:,i)=(Pp(:,:,i)*H')/(H*Pp(:,:,i)*H'+R); %filter gain(filtration)
        Pf(:,:,i)=Pp(:,:,i); %filtration error covariance matrix(filtration)
        Xf(:,i)=Xp(:,i); %improved estimate(filtration)
    end
end

stddevGap=zeros(1,n);
for i = 2:n
    stddevGap(i)=sqrt(Pf(1,1,i));
end
    figure;
    plot(X1(1,:),'b')
    hold on
    plot(z1(1,:),'r')
    hold on
    plot(Xf(1,:),'g')
    grid
    title('Kalman filtering')
    legend('True trajectory','Measurements','Filtered estimates')
    xlabel('Time step')
    ylabel('Estimation of coordinate')



%_TASK 2:FILTERED AND EXTRAPOLATED ERRORS(1&7 STEPS AHEAD) OVER 500 RUNS_%
%________TASK 3:Decrese in accuracy of estimation(P=0 and P=0.2)_________%

%_______________2-1:Estimation of signal with gaps (P=0.2)_______________%
M=500; %number of runs
step=7; %steps ahead
Fstep=F^(step-1);

error1=zeros(M,n);
error2=zeros(M,n);
error3=zeros(M,n);
error4=zeros(M,n);
error5=zeros(M,n);


for i=1:M
    a=normrnd(0,sqrt(sigmasqalpha),1,n);
    etha=normrnd(0,sqrt(sigmasqN),1,n);
      
        for k=2:n
            X1(:,k)=F*X1(:,k-1); %State equation
            z1(k)=H*X1(:,k)+etha(k); %Measurement equation
        end   
        z1(gap<=P)=NaN;     
        for j=3:n
            error1(i,j)=(X1(1,j)-z1(1,j)).^2;
        end

%1 step ahead    
    for k=2:n
    % Filtration if measurements are available
        if isnan(z1(k))~=1 
            Xp(:,k)=F*Xf(:,k-1); %prediction of state vector(extrapolation)
            Pp(:,:,i)=F*Pf(:,:,k-1)*F'+Q; %prediction error covariance matrix(extrapolation)
            K(:,k)=(Pp(:,:,k)*H')/(H*Pp(:,:,k)*H'+R); %filter gain(filtration)
            Pf(:,:,k)=(eye(2)-K(:,k)*H)*Pp(:,:,k); %filtration error covariance matrix(filtration)
            Xf(:,k)=Xp(:,k)+(K(:,k)*(z1(:,k)-H*Xp(:,k))); %improved estimate(filtration)
        end
        
        
        
    % Filtration if measurements are not available
        if isnan(z1(k))==1 
            Xp(:,k)=F*Xf(:,k-1); %prediction of state vector(extrapolation)
            Pp(:,:,k)=F*Pf(:,:,k-1)*F'+Q; %prediction error covariance matrix(extrapolation)
            K(:,k)=(Pp(:,:,k)*H')/(H*Pp(:,:,k)*H'+R); %filter gain(filtration)
            Pf(:,:,k)=Pp(:,:,k); %filtration error covariance matrix(filtration)
            Xf(:,k)=Xp(:,k); %improved estimate(filtration)
        end
            for j=3:n
                error2(i,j)=(X1(1,j)-Xp(1,j)).^2; %extrapolated estimates 1 step
                error3(i,j)=(X1(1,j)-Xf(1,j)).^2; %fileterd estimates 1 step
            end
    end

%7 steps ahead
    for k=2:n
    % Filtration if measurements are available
        if isnan(z1(k))~=1 
            Xp(:,k)=Fstep*Xf(:,k-1); %prediction of state vector(extrapolation)
            Pp(:,:,i)=F*Pf(:,:,k-1)*F'+Q; %prediction error covariance matrix(extrapolation)
            K(:,k)=(Pp(:,:,k)*H')/(H*Pp(:,:,k)*H'+R); %filter gain(filtration)
            Pf(:,:,k)=(eye(2)-K(:,k)*H)*Pp(:,:,k); %filtration error covariance matrix(filtration)
            Xf(:,k)=Xp(:,k)+(K(:,k)*(z1(:,k)-H*Xp(:,k))); %improved estimate(filtration)
        end
    % Filtration if measurements are not available
        if isnan(z1(k))==1 
            Xp(:,k)=Fstep*Xf(:,k-1); %prediction of state vector(extrapolation)
            Pp(:,:,k)=F*Pf(:,:,k-1)*F'+Q; %prediction error covariance matrix(extrapolation)
            K(:,k)=(Pp(:,:,k)*H')/(H*Pp(:,:,k)*H'+R); %filter gain(filtration)
            Pf(:,:,k)=Pp(:,:,k); %filtration error covariance matrix(filtration)
            Xf(:,k)=Xp(:,k); %improved estimate(filtration)
        end
            for j=3:n
                error4(i,j)=(X1(1,j)-Xp(1,j)).^2; %extrapolated estimates 7 steps
                error5(i,j)=(X1(1,j)-Xf(1,j)).^2; %filtered estimates 7 steps
            end
    end    
end
finalerror1=sqrt(sum(error1)./(M-1));
finalerror2=sqrt(sum(error2)./(M-1));
finalerror3=sqrt(sum(error3)./(M-1));
finalerror4=sqrt(sum(error4)./(M-1));
finalerror5=sqrt(sum(error5)./(M-1));

    figure;
    plot(finalerror1,'m')
    hold on
    plot(finalerror2,'b')
    plot(finalerror3,'r')
    plot(finalerror4,'g')    
    plot(finalerror5,'k')   
    grid
    ylim([0 max(finalerror4)+5])
    title('Mean-squared error of estimation over observation interval with gap')
    legend('True estimation error', 'Error of Extrapolated estimates 1 step','Error of Filtered estimates 1 step','Error of Extrapolated estimates 7 step','Error of Filtered estimates 7 steps')
    xlabel('Time step')
    ylabel('Estimated result')

%______________2-2:Estimation of signal without gaps (P=0)_______________%
for i=1:M
    a=normrnd(0,sqrt(sigmasqalpha),1,n);
    etha=normrnd(0,sqrt(sigmasqN),1,n);

    for k=2:n
        X1(:,k)=F*X1(:,k-1); %State equation
        z1(k)=H*X1(:,k)+etha(k); %Measurement equation
            for j=3:n
                error1(i,j)=(X1(1,j)-z1(1,j)).^2;
            end
    end
    
%1 step ahead    
    for k=2:n
    % Filtration if measurements are available
        if isnan(z1(k))~=1 
            Xp(:,k)=F*Xf(:,k-1); %prediction of state vector(extrapolation)
            Pp(:,:,i)=F*Pf(:,:,k-1)*F'+Q; %prediction error covariance matrix(extrapolation)
            K(:,k)=(Pp(:,:,k)*H')/(H*Pp(:,:,k)*H'+R); %filter gain(filtration)
            Pf(:,:,k)=(eye(2)-K(:,k)*H)*Pp(:,:,k); %filtration error covariance matrix(filtration)
            Xf(:,k)=Xp(:,k)+(K(:,k)*(z1(:,k)-H*Xp(:,k))); %improved estimate(filtration)
        end
    % Filtration if measurements are not available
        if isnan(z1(k))==1 
            Xp(:,k)=F*Xf(:,k-1); %prediction of state vector(extrapolation)
            Pp(:,:,k)=F*Pf(:,:,k-1)*F'+Q; %prediction error covariance matrix(extrapolation)
            K(:,k)=(Pp(:,:,k)*H')/(H*Pp(:,:,k)*H'+R); %filter gain(filtration)
            Pf(:,:,k)=Pp(:,:,k); %filtration error covariance matrix(filtration)
            Xf(:,k)=Xp(:,k); %improved estimate(filtration)
        end
            for j=3:n
                error2(i,j)=(X1(1,j)-Xp(1,j)).^2; %extrapolated estimates 1 step without gap
                error3(i,j)=(X1(1,j)-Xf(1,j)).^2; %filtered estimates 1 step without gap
            end
    end
    
%7 steps ahead
    for k=2:n
    % Filtration if measurements are available
        if isnan(z1(k))~=1 
            Xp(:,k)=Fstep*Xf(:,k-1); %prediction of state vector(extrapolation)
            Pp(:,:,i)=F*Pf(:,:,k-1)*F'+Q; %prediction error covariance matrix(extrapolation)
            K(:,k)=(Pp(:,:,k)*H')/(H*Pp(:,:,k)*H'+R); %filter gain(filtration)
            Pf(:,:,k)=(eye(2)-K(:,k)*H)*Pp(:,:,k); %filtration error covariance matrix(filtration)
            Xf(:,k)=Xp(:,k)+(K(:,k)*(z1(:,k)-H*Xp(:,k))); %improved estimate(filtration)
        end
    % Filtration if measurements are not available
        if isnan(z1(k))==1 
            Xp(:,k)=Fstep*Xf(:,k-1); %prediction of state vector(extrapolation)
            Pp(:,:,k)=F*Pf(:,:,k-1)*F'+Q; %prediction error covariance matrix(extrapolation)
            K(:,k)=(Pp(:,:,k)*H')/(H*Pp(:,:,k)*H'+R); %filter gain(filtration)
            Pf(:,:,k)=Pp(:,:,k); %filtration error covariance matrix(filtration)
            Xf(:,k)=Xp(:,k); %improved estimate(filtration)
        end
            for j=3:n
                error4(i,j)=(X1(1,j)-Xp(1,j)).^2; %extrapolated estimates 7 steps without gap
                error5(i,j)=(X1(1,j)-Xf(1,j)).^2; %filtered estimates 7 steps without gap
            end
    end    
end
finalerror6=sqrt(sum(error1)./(M-1));
finalerror7=sqrt(sum(error2)./(M-1));
finalerror8=sqrt(sum(error3)./(M-1));
finalerror9=sqrt(sum(error4)./(M-1));
finalerror10=sqrt(sum(error5)./(M-1));

    figure;
    plot(finalerror6,'m')
    hold on
    plot(finalerror7,'b')
    plot(finalerror8,'r')
    plot(finalerror9,'g')    
    plot(finalerror10,'k')   
    grid
    ylim([0 max(finalerror4)+5])
    title('Mean-squared error of estimation over observation interval without gap')
    legend('True estimated error','Error of Extrapolated estimates 1 step','Error of Filtered estimates 1 step','Error of Extrapolated estimates 7 step','Error of Filtered estimates 7 steps')
    xlabel('Time step')
    ylabel('Estimated result')
    
%_____________3-1:Accuracy of estimation with gaps (P=0.2)_______________%
%with gap
    figure;
    plot(finalerror1,'b');
    hold on;
    plot(stddevGap,'r');
    grid
    ylim([0 max(stddevGap)+7])
    title('Comparison of true estimated error and deviation of estimated error with gaps')
    legend('True estimated error with gaps','Deviation of estimated error with gaps')
    xlabel('Time step')
    ylabel('Estimated result')

%witout gap
for i=2:n
    X1(:,i)=F*X1(:,i-1)+G*a(i); %State equation
    z1(i)=H*X1(:,i)+etha(i); %Measurement equation
end
for i=2:n    
    % Filtration if measurements are available
    if isnan(z1(i))~=1 
        Xp(:,i)=F*Xf(:,i-1); %prediction of state vector(extrapolation)
        Pp(:,:,i)=F*Pf(:,:,i-1)*F'+Q; %prediction error covariance matrix(extrapolation)
        K(:,i)=(Pp(:,:,i)*H')/(H*Pp(:,:,i)*H'+R); %filter gain(filtration)
        Pf(:,:,i)=(eye(2)-K(:,i)*H)*Pp(:,:,i); %filtration error covariance matrix(filtration)
        Xf(:,i)=Xp(:,i)+(K(:,i)*(z1(:,i)-H*Xp(:,i))); %improved estimate(filtration)
    end
    
    % Filtration if measurements are not available
    if isnan(z1(i))==1 
        Xp(:,i)=F*Xf(:,i-1); %prediction of state vector(extrapolation)
        Pp(:,:,i)=F*Pf(:,:,i-1)*F'+Q; %prediction error covariance matrix(extrapolation)
        K(:,i)=(Pp(:,:,i)*H')/(H*Pp(:,:,i)*H'+R); %filter gain(filtration)
        Pf(:,:,i)=Pp(:,:,i); %filtration error covariance matrix(filtration)
        Xf(:,i)=Xp(:,i); %improved estimate(filtration)
    end
end

stddevWithoutGap=zeros(1,n);
for i = 2:n
    stddevWithoutGap(i)=sqrt(Pf(1,1,i));
end

    figure;
    plot(finalerror6,'b');
    hold on;
    plot(stddevWithoutGap,'r');
    ylim([0 max(stddevGap)+7])
    grid
    title('Comparison of true estimated error and deviation of estimated error without gaps')
    legend('True estimated error without gaps','Deviation of estimated error without gaps')
    xlabel('Time step')
    ylabel('Estimated result')
