function [ ExpArr ] = smoothExp( Array, alpha )
    n = length(Array);
    ExpArr(n)=zeros();
    ExpArr(1)=Array(1);
    for i=2:n
        ExpArr(i)=ExpArr(i-1)+alpha*(Array(i)-ExpArr(i-1));
    end
end

