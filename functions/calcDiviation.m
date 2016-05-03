function [diviation] = calcDiviation(SmoothArr,Arr)

    diviation = sum((Arr-SmoothArr).^2);

end