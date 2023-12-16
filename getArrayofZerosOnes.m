function codewords2 = getArrayofZerosOnes(codewords)
for i = 1:length(codewords)
    codeKeeper = [];
    for j = 1:length(codewords{i})
        codeKeeper(j) = str2num(codewords{i}(j)); 
    end
    codewords2{i} = codeKeeper;
end
end

