function s = saveAllNonDependentPropertiesToStruct(obj)
    props = getfield(eval(['?' class(obj)]),'PropertyList');
    for f= 1:numel(props)
        prop = props(f);
        if prop.Dependent || isa(obj.(prop.Name),'event.listener') || iscell(obj.(prop.Name)) && any(cellfun(@(x)isa(x,'event.listener'),obj.(prop.Name)))
            continue
        end
        % save
        s.(prop.Name) = obj.(prop.Name);
    end
end