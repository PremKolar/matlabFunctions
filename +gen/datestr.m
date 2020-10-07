function s = datestr(n,frmt)
    if nargin<2
       frmt = 'yyyy-mm-dd HH:MM:SS'; 
    end
    if iscell(n)
        s=n;
        s(~cellfun('isempty',n)) = cellfun(@(x)datestr(x,frmt),s(~cellfun('isempty',n)),'UniformOutput',0);
    else
        s = datestr(n,frmt);
    end
end