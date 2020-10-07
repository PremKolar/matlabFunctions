function out = checkIdentityFromCellToCellOfAvector(in)
    validateattributes(in,{'cell'},{'vector'})
    out = false(size(in));
    
    for j=2:numel(in)
        out(j) = gen.checkIdentity(in{j},in{j-1});
    end
    
end