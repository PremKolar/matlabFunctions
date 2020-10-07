% NK
% for displaying objects..
% dont use this in your code
function T = obj2table(obj)
    assert(isobject(obj))
    assert(numel(obj)>=1)
    
    P = properties(obj);
    
    data  = {};
    variableNames = {};
    
    for j=1:numel(P)
        if ischar(obj.(P{j})) || isnumeric(obj.(P{j}))
            variableNames = [variableNames {P{j}}]; %#ok<*AGROW>
            data = [data {obj.(P{j})}];
        end
    end
    
    T = cell2table(data,'VariableNames',gen.cleanStr(variableNames,1));
end