function [ XStateVec, Vel, Measurments  ] = calcTrajectory3( Acc, Noise, x1, v1, t)
    
    n=length(Acc);
    XStateVec(n) = zeros();
    XStateVec(1) = x1;
    Vel(n) = zeros();
    Vel(1) = v1;

    for i = 2:n
        Vel(i) = Vel(i-1) + Acc(i-1)*t;
        XStateVec(i) = XStateVec(i-1) + Vel(i-1)*t + (Acc(i-1)*t^2)/2;
    end

    Measurments = XStateVec + Noise;

end

