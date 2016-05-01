n=3;
index=1;
C= cell(n,1);
for k=1:n
    z=nchoosek(1:4,k)
    [rows, ~] = size(z);
    for i=1:rows
        C{index} = z (i,:);
        index = index+1;
        
    end
end
C