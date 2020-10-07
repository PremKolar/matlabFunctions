% NK
function d = extractfield(s,f)
    FN = fieldnames(s);
    d = [];
    for n=1:numel(FN)
        fn = FN{n};
        try
            h = s.(fn).(f);
        catch
            h = []; % if field ~exists
        end
        if ischar(h)
            h = {h};
        end
        d = [d h]; %#ok<AGROW>
    end
end