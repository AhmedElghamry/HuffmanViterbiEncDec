function bitStream = ConvolutionalDecoder(receivedStream)
    receivedStream = hardRound(receivedStream);
    if (rem(receivedStream,3) ~= 0)
       receivedStream = [receivedStream zeros(1,3-rem(receivedStream,3))];
    end
    numberOfStages = length(receivedStream)/3;
    currentStage = 1;
    stream = receivedStream;
    trellisTree = {{[0 0 0],[1 1 1]},{[0 0 1],[1 1 0]},{[0 1 1],[1 0 0]},{[0 1 0],[1 0 1]}};
    decodingTree = {}; 
    
    for i = 1:3:length(stream)
        code = stream(i:i+2);
        if (currentStage == 1)
            decodingTree{currentStage} = {{{trellisTree{1,1}{1,1},countError(code,trellisTree{1,1}{1,1})},{}};
                {{},{}};
                {{trellisTree{1,1}{1,2},countError(code,trellisTree{1,1}{1,2})},{}};
                {{},{}}};
            %finalErrors = [countError(code,trellisTree{1,1}{1,1}),0,countError(code,trellisTree{1,1}{1,2}),0];
        elseif (currentStage == 2)
            decodingTree{currentStage} = {{{trellisTree{1,1}{1,1},countError(code,trellisTree{1,1}{1,1}) + decodingTree{currentStage - 1}{1,1}{1,1}{1,2}},{{},{}}};
                {{trellisTree{1,3}{1,1},countError(code,trellisTree{1,3}{1,1}) + decodingTree{currentStage - 1}{3,1}{1,1}{1,2}},{{},{}}};
                {{trellisTree{1,1}{1,2},countError(code,trellisTree{1,1}{1,2}) + decodingTree{currentStage - 1}{1,1}{1,1}{1,2}},{{},{}}};
                {{trellisTree{1,3}{1,2},countError(code,trellisTree{1,3}{1,2}) + decodingTree{currentStage - 1}{3,1}{1,1}{1,2}},{{},{}}}};
            %finalErrors = min(finalErrors,[countError(code,trellisTree{1,1}{1,1}),0,countError(code,trellisTree{1,1}{1,2}),0]);
        else
            decodingTree{currentStage} = {{{trellisTree{1,1}{1,1},countError(code,trellisTree{1,1}{1,1}) + getError(decodingTree{currentStage - 1}{1,1})},{trellisTree{1,2}{1,1},countError(code,trellisTree{1,2}{1,1}) + getError(decodingTree{currentStage - 1}{2,1})}};
                {{trellisTree{1,3}{1,1},countError(code,trellisTree{1,3}{1,1}) + getError(decodingTree{currentStage - 1}{3,1})},{trellisTree{1,4}{1,1},countError(code,trellisTree{1,4}{1,1}) + getError(decodingTree{currentStage - 1}{4,1})}};
                {{trellisTree{1,1}{1,2},countError(code,trellisTree{1,1}{1,2}) + getError(decodingTree{currentStage - 1}{1,1})},{trellisTree{1,2}{1,2},countError(code,trellisTree{1,2}{1,2}) + getError(decodingTree{currentStage - 1}{2,1})}};
                {{trellisTree{1,3}{1,2},countError(code,trellisTree{1,3}{1,2}) + getError(decodingTree{currentStage - 1}{3,1})},{trellisTree{1,4}{1,2},countError(code,trellisTree{1,4}{1,2}) + getError(decodingTree{currentStage - 1}{4,1})}}};
            decodingTree = hardDecision(decodingTree, currentStage);
        end
        currentStage = currentStage + 1;
    end
    
    finalStage = decodingTree{numberOfStages};
    finalErrors = [finalStage{1,1}{1,1}{1,2},finalStage{1,1}{1,2}{1,2},finalStage{2,1}{1,1}{1,2},finalStage{2,1}{1,2}{1,2},finalStage{3,1}{1,1}{1,2},finalStage{3,1}{1,2}{1,2},finalStage{4,1}{1,1}{1,2},finalStage{4,1}{1,2}{1,2}];
    
    index = find(cell2mat(finalErrors) == min(cell2mat(finalErrors)),1);
    bitStream = flip(getDecodedStream(index, decodingTree, numberOfStages));
end