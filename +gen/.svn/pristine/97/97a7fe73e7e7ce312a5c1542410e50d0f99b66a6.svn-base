function out = concatSingleDigitNumbers(V)
    
    assert(isnumeric(V))
    V = double(V);
    validateattributes(V,{'double'},{'vector'})
    
    out = sum(V.*10.^[length(V)-1:-1:0]);
end
