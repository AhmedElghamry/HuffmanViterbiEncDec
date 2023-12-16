function [OutCodes, Count, Indices] = getSameLengthCodes(InCodes, Length)
    OutCodes = {};
    Indices = [];
    Count = 0;
    [r,c] = size(InCodes);
    for i = 1:c
        if length(InCodes{i}) == Length
            Count = Count + 1;
            OutCodes{Count} = InCodes{i};
            Indices(Count) = i;
        end
    end
end