% NK
function d = extractfield2(s,f)
    FN = strsplit(f,'.');
    d = [];
    for j=1:numel(s)
        try
            h = s(j).(FN{1}).(FN{2});
        catch
            h = nan; % if field ~exists
        end
        if ischar(h)
            h = {h};
        end
        d = [d h]; %#ok<AGROW>
    end
end