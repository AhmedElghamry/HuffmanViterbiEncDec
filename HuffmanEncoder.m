function [symbols,  codewords, HuffmanEncodedSig] = HuffmanEncoder(uniChars, Probabilities, fileRead)
%Changing the uniChars array to cell array to suit our purposes later.
for i = 1:length(uniChars)
	uniChars2{i} = uniChars(i);
end

%Keep a copy of the initial probability and unique characters to be used
%later.
uniInit = uniChars2;
probInit = Probabilities;

%% STEP ONE OF HUFFMAN ENCODING

var = 1;
while (length(Probabilities) > 1)
    %Sorting the probabilities in ascending order, and get the indecies of the pre-sorted array of probabilities.
    [Probabilities,indeces] = sort(Probabilities,'ascend');
    
    %Re-arrange the unique charachters according to the input indecies of the
    %pre-sorted probabilities array.
    uniChars2 = uniChars2(indeces);
    
    %Concatenate the letters with least probabilities, and sum the least probabilities.  
	strConcat = strcat(uniChars2(2),uniChars2(1));
	addedProb = sum(Probabilities(1:2));
    
    %The new string and the summed probabilities are then added to the uniChars
    %and probabSorted, respectively, then sort both arrays for the next
    %iteration.
    uniChars2 =  uniChars2(3:length(uniChars2));
	Probabilities = Probabilities(3:length(Probabilities));

	uniChars2 = [uniChars2, strConcat];
	Probabilities = [Probabilities, addedProb];
    
    %The array below are to store the concatenated strings and summed
    %probabilities at each iteration; they are use later for the encoding of
    %characters.
	concatArr(var) = strConcat;
	accProbArr(var) = addedProb;
	var = var + 1;
end


%% STEP TWO OF HUFFMAN ENCODING (Encoding Step)

% The strTree array store the concatenated strings at each iteration and
% the input symbols to build a helpful tree-like sturcture in the encoding process, and the same goes for the probTree variable as well. 
strTree = [concatArr, uniInit];
ProbTree = [accProbArr, probInit];

%Descendingly ordering the probabilities and re-order the strTree accoring
%the indicies.
[ProbTree,indeces] = sort(ProbTree,'descend');
strTree = strTree(indeces);
%=====================================================================
%This part helps to produce an array to be an input to the treelayout
%built-in function, that generate the coordinates of the tree nodes. This
%step is helpful in obtaining the stream of bits later.
Nodes(1) = 0;
for i = 2:length(strTree)
	str = strTree{i};
    c = 1;
	pre = strTree{i-c};
	found = strfind(pre,str);
	while (isempty(found))
		c = c + 1;
		pre = strTree{i-c};
		found = strfind(pre,str);
	end
	Nodes(i) = i - c;
end

%=====================================================================
%In this part, the '0' and '1' codewords are distributed such that when one
%starts from some node up to the root the codeword keeps adding up.
[xs,ys] = treelayout(Nodes);

for i = 2:length(strTree)
	x1 = xs(i);
	y1 = ys(i);

	x2 = xs(Nodes(i));
	y2 = ys(Nodes(i));

	slope  = (y2 - y1)/(x2 - x1);
    
	if (slope > 0)
		onesZeros(i) = 1;
	else
		onesZeros(i) = 0;
	end
end
%=====================================================================
for i = 1:length(strTree)
	codeword{i} = '';

	index = i;
	node = Nodes(index);
    %While the root is not reached starting from the node i, keep concatenating '0' or '1'.
	while(node ~= 0) 
		
        %Use the index to get and convert '0' or '1' from the onesZeros array to string.
        w = num2str(onesZeros(index));   
        
        %Concatenate the obtained '0' or '1' to the codeword of symbol of node i. 
		codeword{i} = strcat(w, codeword{i});
        
        %Set the new index to the number in Nodes of the previous index, then get the node at that index (it keeps going until the root is reached). 
		index = Nodes(index);
		node = Nodes(index);
	end
end


PreCodeBook = [strTree'  codeword'];
%====================================================================
%This part's purpose is to get the symbols and their codewords.
c = 0;
for i = 1:length(PreCodeBook)
    if length(PreCodeBook{i}) == 1
        symbols(i - c) =  PreCodeBook(i); 
        codewords(i - c) = PreCodeBook(i, 2);
    else
        c = c + 1;
    end
end

%% FINAL STEP (Get the text file encoded)
arrofOnesZeros = getArrayofZerosOnes(codewords);
HuffmanDict = [symbols' arrofOnesZeros'];

HuffmanEncodedSig = huffmanenco(fileRead,HuffmanDict);
end









