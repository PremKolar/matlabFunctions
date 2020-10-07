% NK
function out = getDeepField(S,field)
    %     validateattributes(S,{'struct','handle'},{'scalar'}) % slow
    validateattributes(field,{'char'},{'row'})
    if contains(field,'.')
        fields = strsplit(field,'.');
    else
        fields = {field};
    end
    tmp = S;
    for j=1:numel(fields)
        tmp2 =  tmp.(fields{j});
        tmp = tmp2;
        if isempty(tmp)
            out = tmp;
            return
        end
    end
    out = tmp;
end