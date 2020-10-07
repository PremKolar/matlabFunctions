function s = obj2struct(obj)
    s = struct;
    ps = properties(obj);
    for j=1:numel(ps)
        p = ps{j};
        s.(p) = obj.(p);
    end
end