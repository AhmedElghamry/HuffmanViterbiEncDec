function Efficiency = getEfficiency(Entropy,Codewords,Probabilities)
    averageCodewordLength = 0;
    for i = 1:length(Probabilities)
        averageCodewordLength = averageCodewordLength + Probabilities(i)*strlength(Codewords(i));
    end
    Efficiency = Entropy/averageCodewordLength;
end