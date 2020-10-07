classdef rowNameMTable < MTable
    
    properties (SetAccess = protected, Hidden)
        RowNames_
    end
    
    properties (Dependent)
        X
    end
    
    
    properties (Dependent, Hidden)
        RowNames
    end
    
    
    methods
        function obj = rowNameMTable(varargin)
            obj@MTable(varargin{:});
        end
        
        
        function out = get.RowNames(obj)
            if ~strcmp(obj.ColumnName,'Row Name')
                out = [];
            else
                out = obj.Data(:,1);
            end
        end
        
        function set.RowNames(obj,value)
            if ~strcmp(obj.ColumnName,'Row Name')
                obj.addEmptyColumn(0,'Row Name');
            end
            if isempty(value) % remove
                obj.CellEditable(:,1)=true;
                obj.deleteColumn(1);
                obj.hasRowNames = false;
            else % add
                obj.Data(:,1) = value;
                obj.CellHighlight(:,1) = true;
                obj.hasRowNames = true;
            end
        end
        
        
        function X = get.X(obj) 
            X = size(obj.Data_,2) - obj.hasRowNames;
        end
        
    end
end









