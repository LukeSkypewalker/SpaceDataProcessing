function SmoothArray = smooth(Array,m)

%13-month running mean
n = length(Array);
k=floor(m/2);
SmoothArray(n) = zeros(); 
SmoothArray(1:k) = mean(Array(1:k));
for i = k+1 : n-k
    SmoothArray(i) = sum(Array(i-k:i+k))/m;
end
SmoothArray(n-k:n)=mean(Array(end-k:end));