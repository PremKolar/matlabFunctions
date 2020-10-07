% show sub rows for each row or hide them
function toggleShowSubEntriesOnMTable(MT,numOfSubs,show)
    try
        rowheight = max(MT.RowHeight(:));
    catch
        rowheight = 16;
    end
    Y = size(MT.Data,1);
    flags = true(Y,1);
    N = Y/(numOfSubs+1); % num of chunks
    for n = 1:N
        flags((n-1)*(numOfSubs+1)+1) = false;
    end
    if show
        MT.RowHeight = rowheight;
    else
        MT.RowHeight = ~flags'*rowheight;
    end
end