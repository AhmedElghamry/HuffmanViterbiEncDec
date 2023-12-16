function h = getEntropy(p, len)
h = 0;
for i = 1:len
   h = h - p(i)*log2(p(i));
end
end