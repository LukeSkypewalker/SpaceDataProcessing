function [ X, Measurments, Acc, Noise ] = randomAcceleration( n, sigmaW, sigmaN, x1, v1, t)

    Acc = normrnd(0,sigmaW,1,n);
    Noise = normrnd(0,sigmaN,1,n);

    X(n) = zeros();
    X(1) = x1;
    Vel(n) = zeros();
    Vel(1) = v1;

    for i = 2:n
        Vel(i) = Vel(i-1) + Acc(i)*t;
        X(i) = X(i-1) + Vel(i-1)*t + (Acc(i)*t^2)/2;
    end

    Measurments = X + Noise;

end

