function inout = nan2void(inout)
    if ~iscell(inout)
        inout(isnan(inout)) =  [];
    else
        for j=1:numel(inout)
            if isnan(inout{j})
                inout{j} = [];
            end
        end
    end
end