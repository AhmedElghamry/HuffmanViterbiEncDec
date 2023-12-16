function text = HuffmanDecoder(streamOfBits,codes,symbols)
text = "";

[r,c] = size(codes);
maxCodewordLength = 0;
for i = 1:c
   maxCodewordLength = max(maxCodewordLength,length(codes{1,i}));
end
lastCode = 0;
i = 1;
while (i <= length(streamOfBits))
    codewordLen = 1;
    Hammin = inf * ones(1,c);
    while((~ismember(codes,streamOfBits(i:i+codewordLen-1))) & (codewordLen < maxCodewordLength + 1 && i + codewordLen <= length(streamOfBits)))
       if (i + codewordLen >= length(streamOfBits))
           lastCode = 1;
       end
       [sameLengthCodes, sameLengthCount, sameLengthIndices] = getSameLengthCodes(codes,codewordLen); 
       for k = 1 : sameLengthCount
           Hammin(sameLengthIndices(k)) = countError(cell2mat(sameLengthCodes(k)), streamOfBits(i:i+codewordLen-1));
       end
       codewordLen = codewordLen + 1;
    end
    if (codewordLen == maxCodewordLength + 1) || lastCode
        ind = find(Hammin == min(Hammin),1);
        text = append(text,symbols(ind));
    else
        text = append(text,symbols(ismember(codes,streamOfBits(i:i+codewordLen-1))));
    end
    i = i + codewordLen;
end
text = char(text);
end