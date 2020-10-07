function clearObj(obj)
    eval(['mc = ?' class(obj) ';']);
    FN = fieldnames(obj);
    for f=1:numel(FN)
        if mc.PropertyList(FN{f}).Dependent
            continue
        end
        try %#ok<TRYNC>
            delete(obj.(FN{f}));
        end
        try %#ok<TRYNC>
            obj.(FN{f}) = [];
        end
    end
end
