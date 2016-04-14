function [ X, Measurements, RandWalk, Noise ] = randomWalk( n, sigmaW, sigmaN, x1 )

    RandWalk = normrnd(0,sigmaW,1,n);
    Noise = normrnd(0,sigmaN,1,n);
    X(n) = zeros();
    Measurements(n) = zeros();

    X(1)=x1;
    Measurements(1)=X(1)+RandWalk(1);

    for i=2:n
        X(i)=X(i-1)+RandWalk(i);
        Measurements(i)=X(i)+Noise(i);
    end

end

