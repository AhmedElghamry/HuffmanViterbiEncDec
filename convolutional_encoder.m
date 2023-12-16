function convolution_code = convolutional_encoder(input_sequence)
    generator_functions = [1, 0, 0; 1, 1, 0; 1, 1 ,1];  % The polynomial generator functions matrix according to the design shown in the .pdf file submitted with the code.

    path_1_output = mod(conv(input_sequence,generator_functions(1,:)), 2);  % Getting the output of the convolution between the input sequence and the first polynomial generator function.
    path_2_output = mod(conv(input_sequence,generator_functions(2,:)), 2);  % Getting the output of the convolution between the input sequence and the second polynomial generator function.
    path_3_output = mod(conv(input_sequence,generator_functions(3,:)), 2);  % Getting the output of the convolution between the input sequence and the Third polynomial generator function.
    
    pre_convolution_code = [path_1_output; path_2_output; path_3_output];
    pre_convolution_code = reshape(pre_convolution_code, 1, []);  % The output sequence as a result of multiplexing the paths' output.
    convolution_code = pre_convolution_code(1:end - 6);  % Discarding the last 6 bits as they don't represent codewords in the original bit stream.
end

