function [y,x,linIdx] = findIndexInCellsWithKey(C,key,vertical)
    [y,x] = find(cellfun(@(c) strcmp(c,key),C),1);
    if nargin>2 && vertical
        y = y+1;
    else
        x = x+1;
    end
    if isempty(y)
        error('can''t find %s',key)
    end
    linIdx = sub2ind(size(C),y,x);
end