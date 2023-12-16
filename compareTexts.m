function [] = compareTexts(originalText, decodedText, SNR)
    falseCharNumber = 0;
    if length(decodedText) < length(originalText)
        for i = 1:length(decodedText)
            if ~strcmp(originalText(i), decodedText(i))
                falseCharNumber = falseCharNumber + 1;
            end
        end
        falseCharNumber = falseCharNumber + (length(originalText) - length(decodedText));
    else
        for i = 1:length(originalText)
            if ~strcmp(originalText(i), decodedText(i))
                falseCharNumber = falseCharNumber + 1;
            end
        end
        falseCharNumber = falseCharNumber + (length(decodedText) - length(originalText));
    end
    disp(strcat('Given that the SNR = ',{' '}, num2str(SNR), {' '},'dB',', the number of characters recieved in error is ',{' '}, num2str(falseCharNumber), {' '}, 'characters.'))
end

