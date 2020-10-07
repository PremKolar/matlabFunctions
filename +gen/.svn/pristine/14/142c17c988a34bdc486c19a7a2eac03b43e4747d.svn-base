function highlightNonEqualValuesInMTable(MT,colA,colB,colHL,color)
    data = MT.Data;
    MT.CellHighlightColor = color;
    
    A = data(:,colA);
    B = data(:,colB);
    
    
    try
        cell2mat(A);
        cell2mat(B);
        isnum=true;
    catch
        isnum=false;
    end
    
    try %#ok<TRYNC>
        if ~isnum
            nonEq = cellfun(@(a,b) ~isempty(a)&&~isempty(b)&&~strcmp(strip(a),strip(b)),A,B);
        else
            nonEq = cellfun(@(a,b) ~isempty(a)&&~isempty(b)&&a~=b,A,B);
        end
        
        MT.CellHighlight(nonEq,colHL)  = true;
        MT.CellHighlight(~nonEq,colHL) = false;   
    end
end