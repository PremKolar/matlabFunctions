% feed like so
% types = {'a';'b';'c'}
% colors = [[1 0 0];[0 1 0];[0 0 1]]
% See also GEN.COLORPICKER.
classdef colorDictionaryObj < handle
    
    properties %(SetAccess = protected)
        dict % Map
    end
    
    properties (Dependent)
        asCell
        types
        colors
    end
    
    
    methods
        function obj = colorDictionaryObj(types,colors)
            if nargin==2
                validateattributes(types,{'cell'},{'column'});
                validateattributes(colors,{'double'},{'size',[numel(types),3]});
                obj.dict = containers.Map(types,num2cell(colors,2));
            else
                obj.dict = containers.Map();
            end
        end
        function insert(obj,type,color)
            validateattributes(type,{'char'},{'row'});
            validateattributes(color,{'double'},{'size',[1,3]});
            obj.dict(type) = color;
        end
        function out = get.types(obj)
            out = obj.dict.keys';
        end
        function out = get.colors(obj)
            out = obj.dict.values';
        end
        function out = get.asCell(obj)
            out = [obj.types obj.colors];
        end
    end
end

