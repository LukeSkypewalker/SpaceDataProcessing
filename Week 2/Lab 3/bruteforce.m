function [ M, Idm, Ivm, Alpha, Ide, Ive ] = bruteforce( Arr )

    n = length(Arr); %number of alphas and m
    Idm(n)=zeros();
    Ide(n)=zeros();
    Ivm(n)=zeros();
    Ive(n)=zeros();
    M(n)=zeros();
    Alpha(n)=zeros();

    for i=1:n

        alpha=0.99-i/(n+10); %guessing optimal alpha
        m=floor(1+i*(n/(2*n))); %guessing optimal window size M, 2 means that maximum half of windowsize would be taken

        XExpB = smoothBackExp(Arr,alpha); %function for exponential smoothing

        SmoothX=smooth(Arr,m); %function for running mean

        [Idm(i), Ivm(i)] = calcInd(SmoothX,Arr);
        [Ide(i), Ive(i)] = calcInd(XExpB,Arr);

        M(i)=m;
        Alpha(i)=alpha;
    end
    
end

