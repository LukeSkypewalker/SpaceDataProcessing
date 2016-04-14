function [idm, ide, ivm, ive] = smoothind(XExpB,SmoothX,Z)

n = length(XExpB);
idm=sum((Z-SmoothX).^2);
ide=sum((Z-XExpB).^2);


ivm=sum((SmoothX(3:n)-2*SmoothX(2:n-1)+SmoothX(1:n-2)).^2);
ive=sum((XExpB(3:n)-2*XExpB(2:n-1)+XExpB(1:n-2)).^2);
   

end

