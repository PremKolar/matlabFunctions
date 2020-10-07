function out = deleteObj(obj,classString) %#ok<STOUT>
    if nargin<2
        classString = class(obj);
    end
    for k=1:numel(obj)
        if isa(obj,classString)
            delete(obj(k));
        end
    end
    eval(['out = ' classString  '.empty;'])
end

