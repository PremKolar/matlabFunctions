classdef BlocksTableBlock < handle
    
    properties
        title
        data
        hasFinalLine = false;
    end
    
    properties (Dependent)
       block 
       X
       Y
    end
    
    
    methods
        function obj = BlocksTableBlock(title)
            obj.title = title;
        end
        
        function out = get.X(obj)
        out = size(obj.data,2);    
        end
        
        function out = get.Y(obj)
        out = size(obj.data,1);    
        end
        
        
        function out = get.block(obj)
            out = cell(size(obj.data,1)+1,size(obj.data,2));
            out{1,1} = obj.title;
            out(2:end,:) = obj.data;
        end
        
        function insertLine(obj,in)
            if isempty(obj.data)
                obj.data = in;
            else
                obj.data(end+1,:) = in;
            end
        end
        
    end
    
end
