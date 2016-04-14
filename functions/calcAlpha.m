function [ alpha ] = calcAlpha( W, N )

    n=length(N);
    Vi(n) = zeros();
    Ro(n) = zeros();

    for i=2:n
        Vi(i)=(W(i)+N(i)-N(i-1))^2;
    end

    for i=3:n
        Ro(i)=(W(i)+W(i-1)+N(i)-N(i-2))^2;
    end

    Vi(1)=[];
    Ro(1:2)=[];

    EV=mean(Vi);
    ER=mean(Ro);

    sigmaN = EV - ER/2;
    sigmaW = ER - EV;

    x=sigmaW/sigmaN;
    alpha = (-x+sqrt(x^2+4*x))/2;

end

