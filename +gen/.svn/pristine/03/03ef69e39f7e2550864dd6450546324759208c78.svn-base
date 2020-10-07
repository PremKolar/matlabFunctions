% show sub rows for row row_idx or hide them
function toggleShowSubEntriesOnMTableOne(MT,numOfSubs,row_idx,show)
    rowheightValue = MT.RowHeight(1);
    if length(MT.RowHeight)==1
        flags = true(size(MT.Data,1),1);
    else
        flags = logical(MT.RowHeight);
    end
    
    rowsToToggle =  row_idx+1:row_idx+numOfSubs;
    
    if show
        flags(rowsToToggle) = true;
    else
        flags(rowsToToggle) = false;
    end
    
    [y,x] = size(flags);
    if y>x, flags=flags';end
    
    
    MT.RowHeight = flags*rowheightValue;
    
    
    
end