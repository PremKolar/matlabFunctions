% NK
function ie = isempty(x,stripOtion)
    if nargin<2
        stripOtion = false;
    end
    if iscell(x)
        if stripOtion
            x(cellfun(@ischar,x)) = cellfun(@strip,x(cellfun(@ischar,x)),'UniformOutput',0);
        end
        ie = cellfun('isempty',x);
    else
        if stripOtion
            ie = isempty(strip(x));
        else
            ie = isempty(x);
        end
    end
end