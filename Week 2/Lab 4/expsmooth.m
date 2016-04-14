function [XExp,XExpB] = expsmooth(Array , alpha )
n = length(Array);

XExp(n)=zeros();
XExp(1)=Array(1);

for i=2:n
    XExp(i)=XExp(i-1)+alpha*(Array(i)-XExp(i-1));
end

XExpB(n)=zeros();
XExpB(n)=XExp(n);

for i=n-1:-1:1
  XExpB(i)=  XExpB(i+1)+alpha*(XExp(i)-XExpB(i+1));
end

end

