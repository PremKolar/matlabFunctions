% similiar to table.m, only for numericals, much faster
classdef NumTable < handle
    
    properties
        colNames
        info % use to store metadata
    end
    
    
    properties (Dependent)
        data
        fields
        rowNames        
        varNames   
        isEmpty
    end
    
    properties (Hidden)
        data_ = struct
%         rows_clean
%         vars_clean
        rowNames_
        varNames_
    end
    
    events
       dataChange 
    end
    
    methods
        function obj = NumTable()
            
        end
        
        function c = copy(obj)            
            c = gen.NumTable;
            if isempty(obj)
               return 
            end
            c.colNames = obj.colNames;
            c.info = obj.info;
            c.data_ = obj.data_;
%             c.rows_clean = obj.rows_clean;
%             c.vars_clean = obj.vars_clean;
            c.rowNames_ = obj.rowNames_;
            c.varNames_ = obj.varNames_;
        end
        
        function out = get.isEmpty(obj)
            out = isempty(obj.fields);
        end
      
        function set.rowNames(obj,values)
            obj.rowNames_  = values;            
%             obj.rows_clean = gen.cleanStr(values); % can save lots of time later
        end
        
        function set.varNames(obj,values)
            obj.varNames_  = values;
%             obj.vars_clean = gen.cleanStr(values); % can save lots of time later
        end
        
        function out = get.rowNames(obj)
            out = obj.rowNames_;
        end
        
        function out = get.varNames(obj)
            if isempty(obj.varNames_)
               obj.varNames_ = gen.cleanStr(obj.colNames); 
            end
            out = obj.varNames_;
        end
        
        function out = get.fields(obj)
            out = fieldnames(obj.data_);
        end
        
        function set.fields(obj,value)
            FN = fieldnames(obj.data_);
           assert(numel(value)==numel(FN));
            for k = 1:numel(value)
               if ~strcmp(value{k},FN{k})
                   obj.data_.(value{k}) = obj.data_.(FN{k});
                   obj.data_ = rmfield(obj.data_,FN{k});
               end
            end
        end
                
        function out = get.data(obj)
            for j=1:numel(obj.fields)
                field = obj.fields{j};
                out.(field) = obj.load(field);
            end
        end
                     
        function rmfield(obj,field) % was delete
            obj.data_ = rmfield(obj.data_,field);
        end
        
        function insert(obj,field,newData)
            if istable(newData)
                newData = table2array(newData);
            end
            obj.data_.(field) = newData;
            notify(obj,'dataChange')
        end
        
        function insertSingleValue(obj,field,rowName,varName,newValue)
            y = find(strcmp(obj.rowNames_,rowName));
            x = find(strcmp(obj.varNames_,gen.cleanStr(varName)));
            obj.data_.(field)(y,x) = newValue; %#ok<FNDSB>
            obj.recalSum(field);
            notify(obj,'dataChange')
        end
        function recalSum(obj,field)
            if ~strcmp('sum',obj.varNames{end})
                return
            end
            obj.data_.(field)(:,end) = sum(obj.data_.(field)(:,1:end-1),2);
        end
        function out = load(obj,field)
            if size(obj.data_.(field),1) == numel(obj.rowNames) && size(obj.data_.(field),2) == numel(obj.varNames)
                out = obj.num2MTreadyTable(obj.data_.(field),obj.rowNames,obj.varNames,obj.colNames);
            else
                warning('dimensions of row/colnames don''t agree with data!')
                out =  obj.data_.(field);
            end
        end
        
        function setAllViaStruct(obj,S,rows,vars)
            obj.rowNames = rows;
            obj.varNames = vars;
            FN = fieldnames(S);
            for f=1:numel(FN)
                obj.insert(FN{f},S.(FN{f}));
            end
        end
    end
    
    
    
    methods (Access = private)
        
       
    end
    
    methods (Static)
        
         function T = num2MTreadyTable(matrix,rownames,varnames,colnames)
            T = array2table(matrix,'RowNames',rownames,'variableNames',varnames); % major bottleneck!
            T = gen.appendRealColumnNamesToTable(T,colnames); % for later use in MTable
        end
        
        function n = mat2NumTable(M,variableNames,rowNames,colNames)
            n = gen.NumTable;
            n.rowNames = rowNames;
            n.varNames = variableNames;
            if nargin>3
                n.colNames = colNames;
            end
            for j=1:numel(variableNames)
                n.insert(variableNames{j},M(:,j));
            end
        end
        function n = cell2NumTable(C,varargin)            
            n = gen.NumTable.mat2NumTable(cell2mat(C),varargin{:});
        end
    end
end

