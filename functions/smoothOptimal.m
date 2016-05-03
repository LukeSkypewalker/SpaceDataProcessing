function smoothedArr = smoothOptimal(Arr, beta)

    d2 = ones(11, 1);
    d1 = [-2; -4*ones(10, 1); -2];
    d0 = [1+beta; 5+beta; (6+beta)*ones(9,1); 5+beta; 1+beta];

    A = diag(d0) + diag(d1, -1) + diag(d1, 1) + diag(d2, -2) + diag(d2, 2);
    A_inv = inv(A);

    smoothedArr = zeros(length(Arr),1);

    smoothedArr(1:6) = mean(Arr(1:6));
    for i = 7:length(Arr)-6
        smoothedArr(i) = beta * A_inv(7,:) * Arr(i-6:i+6);
    end    
    smoothedArr(end - 5 : end) = mean(Arr(end - 5 : end));

end 