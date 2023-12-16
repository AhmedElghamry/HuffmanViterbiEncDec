function probabilities = getProbabilities(fileRead, uniChars)
fileLen = length(fileRead);

uniLen = length(uniChars);

probabilities = zeros(1, uniLen);
  
for i = 1 : uniLen
   probabilities(i) = length(strfind(fileRead, uniChars(i))) / fileLen;
end

end

