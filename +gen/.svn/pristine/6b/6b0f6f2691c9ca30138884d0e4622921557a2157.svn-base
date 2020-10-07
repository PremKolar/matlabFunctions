function out = findAncestorWithPropP(obj,P)
    assert(isobject(obj))
    validateattributes(P,{'char'},{'row'})
    if isprop(obj,P)
        out = obj;
        return
    end
    if isempty(obj) || ~isprop(obj,'Parent')
        out = [];
    else
        out = gen.findAncestorWithPropP(obj.Parent,P);
    end
end