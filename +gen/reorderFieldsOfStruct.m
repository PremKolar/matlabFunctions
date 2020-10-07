% Current date   = March 04, 2020
% Matlab version = 9.6.0.1072779 (R2019a)
% User name      = U805233
% use OTHERS as fieldname to place all others
function S_ = reorderFieldsOfStruct(S,order)
    validateattributes(S,{'struct'},{'scalar'})
    validateattributes(order,{'cell'},{'vector'})
    FN = fieldnames(S);
    assert(numel(order)==numel(FN) || ismember('OTHERS',order))
    [is,where] = ismember('OTHERS',order);
    if is
        theOthers = setdiff(FN,order,'stable');
        order = [order(1:where-1) theOthers' order(where+1:end) ];
    end
    
    S_ = orderfields(S,order);
    
end