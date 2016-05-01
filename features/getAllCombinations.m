function [ C ] = getAllCombinations( Range )
    n = length(Range)-1;
    index = 1;
    C = cell( n ,1);
    for k = 1:n
        z = nchoosek(Range,k);
        [ numOfRows, ~ ] = size(z);
        for i=1:numOfRows
            C{index} = z (i,:);
            index = index+1;
        end
    end
    celldisp(C)
end

