% Current date   = February 24, 2020
% Matlab version = 9.6.0.1072779 (R2019a)
% User name      = U805233
function S = removeFieldsOfStructLikeRegex(S,pattern)
    validateattributes(S,{'struct'},{'scalar'})
    FN = fieldnames(S);
    for f=1:numel(FN)
        fn = FN{f};        
        if ~all(gen.isempty(regexp(fn,pattern, 'once')))
            try
                S = rmfield(S,fn);
            catch
                
            end
        elseif ~isempty(S.(fn)) && isstruct(S.(fn))
            S.(fn) = arrayfun(@(s)gen.removeFieldsOfStructLikeRegex(s,pattern),S.(fn));
        end
    end
end