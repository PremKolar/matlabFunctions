function c = findSubBlockInCells(C,starty,startx,asNan)
    if nargin>3 && asNan
        hasdata = ~cell2mat(cellfun(@(x)isnumeric(x)&&isnan(x),C,'UniformOutput',false));
    else
        hasdata = ~cell2mat(cellfun('isempty',C));
    end
    % pad
    hasdata = [hasdata false(size(hasdata,1))];
    hasdata = [hasdata; false(size(hasdata,2))];
    
    y = starty+1;
    x = startx+1;
    while any([hasdata(starty:y,x)' hasdata(y,startx:x)])
        if any(hasdata(starty:y,x))
            x = x+1;
        end
        if any(hasdata(y,startx:x))
            y = y+1;
        end
    end
    x = x-1;
    y = y-1;
    
    c = C(starty:y,startx:x);
end