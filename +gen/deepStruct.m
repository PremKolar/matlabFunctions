% Current date   = February 28, 2020
% Matlab version = 9.6.0.1072779 (R2019a)
% User name      = U805233
% not TESTED properly
function S = deepStruct(obj,recursionLevel)
    if nargin<2
        recursionLevel = 0;
    end
    switch class(obj)
        case 'struct'
            S = obj;
        case {'datetime' 'duration' 'string'}
            S = obj;
            return
        otherwise
            if isobject(obj)
                if isempty(obj)
                    S = struct(obj);
                    return
                end
                try
                    S = arrayfun(@struct,obj);
                catch
                    S = arrayfun(@struct,obj,'UniformOutput',false);
                    for k=1:numel(S)
                        try
                            S{k} = rmfield(S{k},'AutoListeners__');
                        end
                    end
                    S = [S{:}];
                end
                meta = metaclass(obj);
                toRemove = intersect({meta.PropertyList([meta.PropertyList.Dependent]).Name},fieldnames(S)); 
                S = rmfield(S,toRemove);
            else
                S = obj;
                return
            end
    end
    FN = fieldnames(S);
    for f = 1:numel(FN)
        for a = 1:numel(S)
            if recursionLevel==0
                fprintf('obj2struct: %d%% done...\n',round(((f-1)/numel(FN) +a/numel(S)/numel(FN) )*100))
            end
            S(a).(FN{f}) = gen.deepStruct(S(a).(FN{f}),recursionLevel+1); % ok
        end
    end
end