function [id, iv] = calcInd(SmoothArr,Arr)

    id=sum((Arr-SmoothArr).^2);
    iv=sum((SmoothArr(3:end)-2*SmoothArr(2:end-1)+SmoothArr(1:end-2)).^2);

end