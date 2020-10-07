% see also gen.colorDictionaryObj.
classdef colorpicker < fmtOOP.interfaces.UItools
    
    properties
        title='color picker'
        colorObj
        MTable
    end
    
    methods
        function obj = colorpicker(colorObj,Parent)
            assert(isa(colorObj,'gen.colorDictionaryObj'));
            assert(isvalid(colorObj));
            obj.colorObj = colorObj;
            if nargin<2
                obj.Parent = figure('NumberTitle','off','Name',obj.title,'menubar','none');
            else
                obj.Parent = Parent;
            end
            obj.MTable = obj.MTableInBox(obj.Parent,'set colors',0,0,0,0,0);
            obj.build;
        end
        
        function setTableColors(obj)
            obj.MTable.CellColor(:,2) = obj.MTable.truecolor(cell2mat(obj.colorObj.colors));
        end
        
        function build(obj)
            obj.MTable.Data = [obj.colorObj.types cell(numel(obj.colorObj.types),1)];
            obj.setTableColors;
            obj.MTable.ColumnName = {'key','color'};
            obj.MTable.autoColumnWidth;
            obj.MTable.CellEditable = 0;
            obj.MTable.CellSelectionCallback = {@(h,e)obj.callback(h,e)};
            obj.Parent.Position(3)=sum(obj.MTable.ColumnWidth)*5;
            obj.Parent.Position(4)=min([30+20*numel(obj.colorObj.types) 500]);
        end
        
        function callback(obj,hObj,evdata)
            col = evdata.Indices(2);
            if col~=2
                return
            end
            row = evdata.Indices(1);
            
            key = hObj.Data{row,1};
            newColor = uisetcolor(obj.colorObj.dict(key));           
            obj.colorObj.dict(key) = newColor;
            obj.setTableColors;
        end
    end
end

