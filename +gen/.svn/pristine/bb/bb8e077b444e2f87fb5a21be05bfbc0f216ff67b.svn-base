% NK, display blocks of data
classdef BlocksTable < MTable
    
    properties
        Blocks = gen.BlocksTableBlock.empty
        finalLineColor = [0.85    0.85    0.85]
        titleColor     = [0.1     0.7     0.7]
    end
    
    
    properties (Dependent)
        Y2 % projected dims
        X2
    end
    
    properties (Hidden)
        CellHighlight2
        finalLineIdcs
        titleIdcs
    end
    
    
    methods
        function obj = BlocksTable(varargin)
            assert(isa(varargin{1},'ui'));
            obj@MTable(varargin{:});
            obj.build;
            
        end
        
        function out = get.X2(obj)
            out = max([obj.Blocks.X]);
        end
        
        function out = get.Y2(obj)
            out = sum([obj.Blocks.Y])+2*numel(obj.Blocks)-1;
        end
        
        
        function build(obj)
            data = cell(obj.Y2,obj.X2);
            obj.titleIdcs = false(obj.Y2,1);
            obj.finalLineIdcs = false(obj.Y2,1);
            y=1;
            for k=1:numel(obj.Blocks)
                obj.titleIdcs(y) = true;
                B = obj.Blocks(k);
                data(y:y+B.Y,1:B.X) = B.block;
                if B.hasFinalLine
                    obj.finalLineIdcs(y+B.Y-B.hasFinalLine+1:y+B.Y) = true;
                end
                y = y+B.Y+1+1;
                
            end
            %
            obj.Data = data;
            obj.setTitleColor;
            obj.setFinalLineColor;
        end
        function clear(obj)
           arrayfun(@delete,obj.Blocks);
           obj.Blocks = gen.BlocksTableBlock.empty;
           obj.Data = [];
        end
        
        function addBlock(obj,Block)
            assert(isa(Block,'gen.BlocksTableBlock'))
            obj.Blocks(end+1) = Block;
            obj.build;
        end
        
        function setTitleColor(obj)
            if ~any(obj.titleIdcs)
                return
            end
            obj.CellColor_(obj.titleIdcs,:) = cellfun(@(y) obj.truecolor(y),arrayfun(@(x) {(floor(mod(x./[256^2 256^1 256^0],256))/255).*obj.titleColor},double(obj.CellColor_(obj.titleIdcs,:))));
            obj.table.setBgColorX(obj.CellColor_);
        end
        
        function setFinalLineColor(obj)
            if ~any(obj.finalLineIdcs)
                return
            end
            obj.CellColor_(obj.finalLineIdcs,:) = cellfun(@(y) obj.truecolor(y),arrayfun(@(x) {(floor(mod(x./[256^2 256^1 256^0],256))/255).*obj.finalLineColor},double(obj.CellColor_(obj.finalLineIdcs,:))));
            obj.table.setBgColorX(obj.CellColor_);
        end
        
    end
end