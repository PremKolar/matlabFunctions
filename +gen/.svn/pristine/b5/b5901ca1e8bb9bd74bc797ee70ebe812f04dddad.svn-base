% NK
% MTable that supports gen.money
classdef MTable_money < MTable
    
    properties
        showCents = true
    end
    
    properties (SetAccess = protected)
        isMoney
        currentEuroPrice = 1
        currentCurrency = '€'
    end
    
    properties (Hidden)
        Data_withMoney
    end
    
    
    
    methods
        function obj = MTable_money(varargin)
            obj@MTable(varargin{:});
            addlistener(obj,'manualEditOfAValue',@(h,e)obj.editcallback(h,e));
        end
        
        function set.showCents(obj,value)
            obj.showCents = value;
            obj.Data = obj.Data_withMoney; %#ok<MCSUP>
        end
        
        function changeCurrency(obj,currency,euroPrice)
            narginchk(1,3);
            if nargin==1
                currency = '€';
                euroPrice = 1;
            end
            obj.currentEuroPrice = euroPrice; % remember
            obj.currentCurrency  = currency; % remember
            obj.Data_ = obj.moneyToStr(obj.Data_withMoney,obj.showCents,currency,euroPrice);
            obj.table.setVectorX(1,1,obj.Data_);
        end
        
        % @overload
        function setColumnFormatByColumnName(obj,valuepairs)
            setColumnFormatByColumnName@MTable(obj,valuepairs); % standard procedure
            if ~ismember('gen.money',obj.ColumnFormat)
                return
            end
            frmts = cellfun(@class,obj.Data_withMoney,'UniformOutput',0);
            setFrmts = repmat(obj.ColumnFormat,obj.Y,1);
            
            toTransform = reshape(find(~strcmp(frmts,setFrmts) & ~cellfun('isempty',setFrmts)),1,[]);
            if isempty(toTransform)
                return
            end
            for j = toTransform
                switch setFrmts{j}
                    case 'gen.money'
                        if any(strcmp(frmts{j},{'double' 'logical'}))
                            obj.Data_withMoney{j} = gen.money(obj.Data_withMoney{j});
                        elseif strcmp(frmts{j},{'char'})
                            obj.Data_withMoney{j} = gen.money(gen.currency2num(obj.Data_withMoney{j}));
                        end
                end
            end
            obj.setData(obj.Data_withMoney); % refresh
            obj.changeCurrency(obj.currentCurrency,obj.currentEuroPrice); % update to last-chosen currency
        end
    end
    methods (Access = protected)
        % override
        function setData(obj,value)
            obj.Data_withMoney = value;
            [value_moneyAsString,obj.isMoney] = obj.moneyToStr(value,obj.showCents);
            % set Data via super class
            setData@MTable(obj,value_moneyAsString);
        end
        function editcallback(obj,~,eventdata)
            if ~isa(obj.Data_withMoney{eventdata.Indices(1),eventdata.Indices(2)},'gen.money')
                return
            end
            disp('assuming input is in €!');
            euros = eventdata.NewValue;
            if ischar(euros)
                euros = str2double(euros);
            end
            obj.Data_withMoney{eventdata.Indices(1),eventdata.Indices(2)} = gen.money(euros); % not a handle class..
            obj.setData(obj.Data_withMoney); % refresh
            obj.changeCurrency(obj.currentCurrency,obj.currentEuroPrice); % update to last-chosen currency
        end
        
    end
    
    methods (Static)
        function [out, isMoney] = moneyToStr(in,showCents,currency,euroPrice)
            narginchk(2,4);
            if nargin==2
                currency = '€';
                euroPrice = 1;
            end
            validateattributes(currency,{'char'},{'row'});
            validateattributes(euroPrice,{'double'},{'scalar'});
            validateattributes(in,{'cell'},{});
            isMoney = cellfun(@(c)isa(c,'gen.money'),in);
            out = in;
            out(isMoney) = cellfun(@(c)c.asString(currency,euroPrice,showCents),in(isMoney));
        end
    end
end

