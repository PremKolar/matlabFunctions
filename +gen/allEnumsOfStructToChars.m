% Current date   = February 21, 2020
% Matlab version = 9.6.0.1072779 (R2019a)
% User name      = U805233
function S = allEnumsOfStructToChars(S)
    validateattributes(S,{'struct'},{'scalar'})
    FN = fieldnames(S);
    for f=1:numel(FN)
        fn = FN{f};
        if isempty(S.(fn))
            continue
        elseif isa(S.(fn),'containers.Map')
            continue
        elseif isenum(S.(fn)(1))
            if numel(S.(fn))>1
                S.(fn) = arrayfun(@char,S.(fn),'UniformOutput',false); % make cell array
            else
                S.(fn) = char(S.(fn));
            end
        elseif isstruct(S.(fn)(1))
            S.(fn) = arrayfun(@gen.allEnumsOfStructToChars,S.(fn)); % make cell array        
        end
    end
end