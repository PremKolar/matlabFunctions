% NK
% try to make object A same as object B (does not work for private properties!)
function copyFromObj(objA,objB)
    assert(isa(objA,class(objB)));
    assert(numel(objA)==1)
    assert(numel(objB)==1)
    
    eval(['mc = ?' class(objA) ';']); % get meta info on class
    FN = fieldnames(objA);
    for f=1:numel(FN)
        props = mc.PropertyList(strcmp(FN{f},{mc.PropertyList.Name}));
        if props.Dependent || ismember(props.GetAccess,{'private','protected'})
            continue
        end
        
        objA.(FN{f}) = objB.(FN{f}); % if isobject, old objects still alive!
        
    end
end
