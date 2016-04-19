
function [ X, Measurments, Acc, Noise ] = randomAcceleration( n, sigmaW, sigmaN, x1, v1, t)

    Acc = normrnd(0,sigmaW,1,n);
    Noise = normrnd(0,sigmaN,1,n);

    [ X, Measurments  ] = rndAcc( n, Acc, Noise, x1, v1, t)

end

