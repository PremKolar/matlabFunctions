function cellArr = empty2zero(cellArr,asString)
    is = cellfun('isempty',cellArr);
    if nargin>1 && asString
        cellArr(is) = {'0'};
    else
        cellArr(is) = {0};
    end
end