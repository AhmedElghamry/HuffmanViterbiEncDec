clear;
clc;

fileID = fopen('Test_Text_File.txt','r'); %Opening the file to-be-encoded
fileRead = fileread('Test_Text_File.txt'); %Reading the file
fclose(fileID);

uniChars = unique(fileRead); %Getting all symbols (unique characters) and sort them alphabetically
uniLen = length(uniChars); %Number of symbols in the sample space

Probabilities = getProbabilities(fileRead, uniChars); %Getting the probability of occurence of each symbol in the file
% Entropy = getEntropy(Probabilities, uniLen); % Getting the Entropy of all symbols

% fixedLen = ceil(log2(uniLen)); %Number of bits for having a fixed codeword
% fixedCodewords = cellstr(num2str(de2bi(0:uniLen-1),'%d'));
% Efficiency = getEfficiency(Entropy,fixedCodewords,Probabilities); %The efficiency for having a fixed codeword

[symbols,  codewords, HuffmanEncodedSig] = HuffmanEncoder(uniChars, Probabilities, fileRead); %Implementation of Huffman Encoding
Symbol = symbols'; Codeword = codewords';
DispTable = table(Symbol,Codeword)

ConvolutionalEncodedSig = convolutional_encoder(HuffmanEncodedSig);
% 
% SNR = 1:30;
% receivedSignal = [];
% for i = 1:30
%     receivedSignal(i,:) = awgn(HuffmanEncodedSig,SNR(i));
% end 
ConvolutionalDecodedSig = ConvolutionalDecoder(ConvolutionalEncodedSig);

decodedText = HuffmanDecoder(num2str(ConvolutionalDecodedSig,'%d'), codewords, symbols); %Implementation of Huffman Decoding
% for i = 1:30
%     decodedText(i,:) = 
% end
% if (decodedText == fileRead)
%    disp('The Decoded message matches the original one'); 
% end
% fileID = fopen('decoded_txt_file.txt','w');
% fprintf(fileID,decodedText);
% fclose(fileID);

% HuffmanEfficiency = getEfficiency(Entropy,codewords,sort(Probabilities,'descend'));

