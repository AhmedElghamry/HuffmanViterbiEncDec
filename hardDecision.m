function finalizedTree = hardDecision(decodingTree, Stage)
    Tree = decodingTree{Stage};
    Errors = [Tree{1,1}{1,1}{1,2},Tree{1,1}{1,2}{1,2},Tree{2,1}{1,1}{1,2},Tree{2,1}{1,2}{1,2},Tree{3,1}{1,1}{1,2},Tree{3,1}{1,2}{1,2},Tree{4,1}{1,1}{1,2},Tree{4,1}{1,2}{1,2}];
    if (Errors(1) <= Errors(2))
        Tree{1,1}{1,2}{1,1} = {}; Tree{1,1}{1,2}{1,2} = {};
        Errors(2) = inf;
    elseif (Errors(1) > Errors(2))
        Tree{1,1}{1,1}{1,1} = {}; Tree{1,1}{1,1}{1,2} = {};
        Errors(1) = inf;
    end
    
    if (Errors(3) <= Errors(4))
        Tree{2,1}{1,2}{1,1} = {}; Tree{2,1}{1,2}{1,2} = {};
        Errors(4) = inf;
    elseif (Errors(3) > Errors(4))
        Tree{2,1}{1,1}{1,1} = {}; Tree{2,1}{1,1}{1,2} = {};
        Errors(3) = inf;
    end
    
    if (Errors(5) <= Errors(6))
        Tree{3,1}{1,2}{1,1} = {}; Tree{3,1}{1,2}{1,2} = {};
        Errors(6) = inf;
    elseif (Errors(5) > Errors(6))
        Tree{3,1}{1,1}{1,1} = {}; Tree{3,1}{1,1}{1,2} = {};
        Errors(5) = inf;
    end
    
    if (Errors(7) <= Errors(8))
        Tree{4,1}{1,2}{1,1} = {}; Tree{4,1}{1,2}{1,2} = {};
        Errors(8) = inf;
    elseif (Errors(7) > Errors(8))
        Tree{4,1}{1,1}{1,1} = {}; Tree{4,1}{1,1}{1,2} = {};
        Errors(7) = inf;
    end
    
    decodingTree{Stage} = Tree;
    finalizedTree = decodingTree;
end