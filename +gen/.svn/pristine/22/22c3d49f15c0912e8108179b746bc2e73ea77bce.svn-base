% Current date   = February 21, 2020
% Matlab version = 9.6.0.1072779 (R2019a)
% User name      = U805233
function S = allDatenumsOfStructToISO8601(S)
    validateattributes(S,{'struct'},{'scalar'})
    FN = fieldnames(S);
    for f=1:numel(FN)
        fn = FN{f};
        try
            if isempty(S.(fn))
                S.(fn) = [];
                continue
                %        elseif isa(S.(fn),'containers.Map')
                %             continue
            elseif isduration(S.(fn))
                if numel(S.(fn))>1
                    S.(fn) = arrayfun(@gen.datenum2ISO8601datetime,S.(fn),'UniformOutput',false); % make cell array
                else
                    S.(fn) = gen.datenum2ISO8601datetime(S.(fn));
                end
            elseif isstruct(S.(fn))
                S.(fn) = arrayfun(@gen.allDatenumsOfStructToISO8601,S.(fn));
            elseif isdatetime(S.(fn))
                S.(fn) = arrayfun(@gen.datenum2ISO8601datetime,S.(fn));
            end
        catch
            continue
        end
    end
end