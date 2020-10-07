% Current date   = February 21, 2020
% Matlab version = 9.6.0.1072779 (R2019a)
% User name      = U805233
classdef (Abstract) obj2structAbleArray < gen.obj2structAble
   
    properties
       fieldsToKeep (1,:) cell = {} 
    end
    
    methods
        %@overwrite
        function S = toStruct(obj,varargin)
            warning off
            type = [regexprep(class(obj.Values),'.*\.','') 's']; 
            S = struct(obj);
            S = rmfield(S,setdiff(fieldnames(S),[{'Values'} obj.fieldsToKeep]));
            for k=1:numel(S.Values)
                S.(type)(k) = S.Values(k).toStruct(varargin{:});                           
            end
            S = rmfield(S,'Values');
            warning on
        end
    end
end