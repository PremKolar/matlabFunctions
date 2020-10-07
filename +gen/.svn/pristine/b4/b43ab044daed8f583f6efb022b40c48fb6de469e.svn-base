% TODO delete
function S = makeStruct(obj)
    warning off
    S = struct(obj);
    FN = fieldnames(S);
    for k=1:numel(FN)
        fn = FN{k};
        if ~isempty(S.(fn)) && isobject(S.(fn)(1)) && ~isdatetime(S.(fn)) && ~isduration(S.(fn))&& ~isenum(S.(fn))
            fn
            S.(fn) = arrayfun(@gen.makeStruct,S.(fn));          
        end
    end
    warning on
end