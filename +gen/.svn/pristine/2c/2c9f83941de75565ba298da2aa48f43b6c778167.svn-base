% NK
function Sout = structmerge(A,B)
    validateattributes(A,{'struct'},{'numel',1})
    validateattributes(B,{'struct'},{'numel',1})
    Sout = A;
    
    FNA = fieldnames(A);
    FNB = fieldnames(B);
    
    for i = 1:numel(FNB)
        if ismember(FNB{i},FNA)
            warning('replacing %s in first struct!',FNB{i})
        end
        Sout.(FNB{i}) = B.(FNB{i});
    end
end