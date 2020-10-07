% Current date   = February 21, 2020
% Matlab version = 9.6.0.1072779 (R2019a)
% User name      = U805233
% obj2structAble
classdef obj2structAble < handle
    
    properties (Hidden)
        flatEnums logical = true
    end
    properties (SetAccess = protected,Hidden)
        fieldnameOrder cell = cell(0)
    end
    methods
        
        function pullFieldsToTop(obj,fields)
            % TODO check input
            obj.fieldnameOrder = [fields(:)' 'OTHERS'];
        end
        function S = toStruct(obj,omit,jsonReady)
            if nargin<3
                jsonReady = false;
            end
            if nargin<2
                omit = [];
            end
            omit = [omit {'fieldnameOrder' 'flatEnums' 'listener' 'listeners' 'Listener' 'Listeners' 'AutoListeners__' 'PreviousInstance__'}];
            warning off
            S = struct(obj);
            FN = fieldnames(S);
            S = rmfield(S,FN(ismember(FN,omit)));
            FN = fieldnames(S);
            for k=1:numel(FN)
                fn = FN{k};
                if  ischar(S.(fn))
                    continue
                elseif isenum(S.(fn)) && obj.flatEnums
                    S.(fn) = obj.flattenEnums(S.(fn));
                elseif isempty(S.(fn)) || isnumeric(S.(fn))
                    continue
                elseif isstruct(S.(fn))
                    S.(fn) = obj.recurseIntoStruct(S.(fn),jsonReady);
                elseif iscell(S.(fn)) && sum(size(S.(fn))>1)>1 && jsonReady
                    S_ = squeeze(S.(fn));
                    sz = size(S_);
                    C = arrayfun(@(y){S_(y,:)},1:sz(1))';
                    S.(fn) = C;
                elseif isobject(S.(fn))
                    if isstring(S.(fn))
                        continue
                    end
                    
                    if ~isa(S.(fn),'handle')
                        try
                            S.(fn) = arrayfun(@(s)s.toStruct({},jsonReady),S.(fn));
                        end
                    elseif isa(S.(fn),'gen.obj2structAble')
                        tmp = arrayfun(@(s)s.toStruct({},jsonReady),S.(fn));
                        if isfield(tmp,fn)
                            S.(fn) = tmp.(fn);
                        else
                            S.(fn) = tmp;
                        end
                    end
                end
            end
            warning on
            if ~isempty(obj.fieldnameOrder)
                S = gen.reorderFieldsOfStruct(S,obj.fieldnameOrder);
            end
            
        end
        
    end
    
    methods (Static)
        function Sfn = flattenEnums(Sfn)
            if numel(Sfn)>1
                Sfn = arrayfun(@char,Sfn,'UniformOutput',false); % make cell array
            else
                Sfn = char(Sfn);
            end
        end
        function Sout = recurseIntoStruct(Sin,jsonReady)
            FN = fieldnames(Sin);
            Sout = Sin;
            for f = 1:numel(FN)
                fn = FN{f};
                for a = 1:numel(Sin)
                    if isa(Sin(a).(fn),'gen.obj2structAble')
                        Sout(a).(fn) = Sin(a).(fn).toStruct({},jsonReady);
                    elseif isstruct(Sin(a).(fn))
                        Sout(a).(fn) = gen.obj2structAble.recurseIntoStruct(Sin(a).(fn),jsonReady); % recurse
                    elseif isenum(Sin(a).(fn)) && obj.flatEnums
                        Sin(a).(fn) = obj.flattenEnums(Sin(a).(fn));
                    end
                end
            end
        end
    end
end