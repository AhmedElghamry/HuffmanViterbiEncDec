function Stream = getDecodedStream(Index, Tree, nStages)
    decodingTree = [0,0,0,0,1,1,1,1];
    Stream = [];
    for i = nStages : -1 : 1
        if (isempty(Tree{i}{Index,1}{1,1}{1,2}))
            Stream = [Stream decodingTree(2*Index)];
            if (Index == 1) 
                Index = 2; 
            elseif (Index == 2) 
                Index = 4; 
            elseif (Index == 3) 
                Index = 2; 
            else
                Index = 4; 
            end
        else
            Stream = [Stream decodingTree(2*Index-1)];            
            if (Index == 1) 
                Index = 1; 
            elseif (Index == 2) 
                Index = 3; 
            elseif (Index == 3) 
                Index = 1; 
            else
                Index = 3; 
            end
        end
   end
end