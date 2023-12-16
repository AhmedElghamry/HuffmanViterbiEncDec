function num = countError(x1,x2)
if length(x1) ~= length(x2)
    disp('error');
    return
end
num = 0;
for i = 1:length(x1)
    if (x1(i) ~= x2(i))
       num = num + 1; 
    end
end
end