function roundedStream = hardRound(receivedStream)
    for j = 1:length(receivedStream)
        isOne = abs(1-receivedStream(j));
        isZero = abs(0-receivedStream(j));
        if  isOne > isZero
            roundedStream(j) = 0;
        else 
            roundedStream(j) = 1;
        end
    end
end