function SmoothArray = smooth(Array)

    %13-month running mean
    n = length(Array);
    SmoothArray(n) = zeros(); 
    SmoothArray(1:6) = mean(Array(1:6));
    for i = 7 : n-6
        SmoothArray(i) = sum(Array(i-5:i+5))/12 + (Array(i-6)+Array(i+6))/24;
    end
    
SmoothArray(n-5:n)=mean(Array(end-5:end));