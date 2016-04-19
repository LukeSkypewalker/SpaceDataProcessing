function [ X, Measurments  ] = calcTrajectory( Acc, Noise, x1, v1, t)
    
    n=length(Acc);
    X(n) = zeros();
    X(1) = x1;
    Vel(n) = zeros();
    Vel(1) = v1;

    for i = 2:n
        Vel(i) = Vel(i-1) + Acc(i-1)*t;
        X(i) = X(i-1) + Vel(i-1)*t + (Acc(i-1)*t^2)/2;
    end

    Measurments = X + Noise;

end

