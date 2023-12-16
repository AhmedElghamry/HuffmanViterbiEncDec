function error = getError(cell)
if isempty(cell{1,1}{1,2})
    error = cell{1,2}{1,2};
else
    error = cell{1,1}{1,2};
end
end