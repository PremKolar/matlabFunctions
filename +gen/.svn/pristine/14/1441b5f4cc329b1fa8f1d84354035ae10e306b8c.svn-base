% TODO
% phew!
function jsonStr = jsonencode_keepDims(S)
    if iscell(S) && sum(size(S)>1)>1
        S_ = squeeze(S);
        sz = size(S_);
        C = arrayfun(@(y){S_(y,:)},1:sz(1))';
        jsonStr = jsonencode(C);
    elseif isstruct(S)
        FN = fieldnames(S);
        for k=1:numel(S)
            C{k} = cellfun(@(x) gen.jsonencode_keepDims(S(k).(x)),FN,'UniformOutput',false);
                jsonStr =  sprintf('%s,"%s":"%s"',jsonStr,S,C{k}{1});
            if iscell(C{k}{1})
                jsonStr = [jsonStr gen.jsonencode_keepDims(C{k})];
            elseif ischar(C{k}{1})
                jsonStr =  sprintf('%s,"%s":"%s"',jsonStr,S,C{k}{1});
            else
                TODO
            end
        end
        
        
        
        
    else
        jsonStr = jsonencode(S);
    end
end