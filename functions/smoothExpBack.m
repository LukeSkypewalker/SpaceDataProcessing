function [ ExpBackArr ] = smoothExpBack( Array, alpha )
    
    n = length(Array);
    ExpArr = smoothExp(Array, alpha);
    
    ExpBackArr(n)=zeros();
    ExpBackArr(n)=Array(n);
    for i = (n-1) : (-1) : 1
        ExpBackArr(i)=ExpBackArr(i+1)+alpha*(ExpArr(i)-ExpBackArr(i+1));
    end
end

