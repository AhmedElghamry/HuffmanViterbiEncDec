clc;
clear;
clf;
%% Phase-I-Phase-II Integration: Transmitting and recieving convolutionally-coded sequence of bits in AWGN channel with SNR = 10 dB.

file_ID = fopen('Test_Text_File.txt','r'); % Opening the file to-be-encoded
file_read = fileread('Test_Text_File.txt'); % Reading the file
fclose(file_ID);

uni_chars = unique(file_read); % Getting all symbols (unique characters) and sort them alphabetically
uni_length = length(uni_chars); % Number of symbols in the sample space

probabilities = getProbabilities(file_read, uni_chars); % Getting the probability of occurence of each symbol in the file
[symbols,  codewords, Huffman_encoded_sig] = HuffmanEncoder(uni_chars, probabilities, file_read); % Huffman encoding step.
Symbol = symbols'; Codeword = codewords';
DispTable = table(Symbol,Codeword)

channel_encoding = convolutional_encoder(Huffman_encoded_sig);  % Obtaining the convolutionally-coded sequence using a 1/3-rate convolutional encoder.

noised_sequence = awgn(channel_encoding, 5,'measured'); % Adding AWGN to the convolutionally-coded sequence.

decoded_noisy_sequence = ConvolutionalDecoder(noised_sequence);  % Decoding the noised convolutionally-coded sequence.

Huffman_decoded_text = HuffmanDecoder(num2str(decoded_noisy_sequence,'%d'), codewords, symbols); %Implementation of Huffman Decoding

%% Bit Error Rate v.s. SNR: Performence comparison when using the convolutional code v.s. without coding.
SNRs = 0:15;
BER_with_coding = [];
BER_without_coding = [];

for i = 1:length(SNRs)
    noised_Huffman_stream = awgn(Huffman_encoded_sig, SNRs(i), 'measured');   % Adding noise to the Huffman-encoded stream.
    noised_convolutional_stream = awgn(channel_encoding, SNRs(i), 'measured');    % Adding noise to the convolutionally-encoded stream.
    
    decoded_noisy_sequence = ConvolutionalDecoder(noised_convolutional_stream);  % Decoding the noised convolutionally-encoded stream.
    
    rounded_stream = hardRound(noised_Huffman_stream);

    BER_with_coding(i) = biterr(decoded_noisy_sequence, Huffman_encoded_sig)/length(decoded_noisy_sequence);  % Adding 
    BER_without_coding(i) = biterr(rounded_stream, Huffman_encoded_sig)/length(noised_Huffman_stream);
end

figure
semilogy(SNRs, BER_with_coding)
title('BER v.s. SNR')
xlabel('SNR (dB)')
ylabel('BER')
ylim([10e-4 1]);
hold on
semilogy(SNRs, BER_without_coding)
title('BER v.s. SNR')
xlabel('SNR (dB)')
ylabel('BER')
ylim([10e-4 1]);
legend('With Channel Encoding','Without Channel Encoding');
%% Comparing the received text with the input text with and without channel coding at three different SNRs 1,6,11 dB
for SNR = 1:5:15
    noised_convolutional_stream = awgn(channel_encoding, SNR, 'measured');
    decoded_noisy_stream = ConvolutionalDecoder(noised_convolutional_stream);
    decoded_text = HuffmanDecoder(num2str(decoded_noisy_stream,'%d'), codewords, symbols);
    compareTexts(file_read, decoded_text, SNR);
end