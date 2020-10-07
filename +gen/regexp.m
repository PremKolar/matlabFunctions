function out = regexp(x,ptrn)
    if iscell(x)
        out = ~cellfun('isempty',regexp(x,ptrn));
    elseif ischar(x)
        out = regexp(x,ptrn);
    else
        error('not impled');            
    end
end