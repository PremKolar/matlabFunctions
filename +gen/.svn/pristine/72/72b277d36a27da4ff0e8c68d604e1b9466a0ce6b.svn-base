% not a handle class!
classdef money < matlab.mixin.internal.MatrixDisplay
    
    properties (SetAccess = protected)
        conversionRate double = 1 % inital conv. rate
        initialCurrency char = '€'
    end
    
    properties (Access = protected)
        amountInEuros (1,1) double = nan
    end
    
    methods
        
        function obj = money(amount, currency, priceInEuros)
            narginchk(1,3)
            if numel(amount)>1
                if nargin>1
                    obj = arrayfun(@(a)gen.money(a, currency, priceInEuros),amount);
                else
                    obj = arrayfun(@(a)gen.money(a),amount);
                end
            else
                if nargin>1
                    obj.initialCurrency = currency;
                    obj.conversionRate  = 1/priceInEuros;
                    obj.amountInEuros   = amount/obj.conversionRate;
                else
                    obj.amountInEuros   = amount;
                end
            end
            
        end
        
        function disp(obj)           
            details(obj);
            disp(obj.asString)
        end
        
        function out = asString(obj,currency,euroPrice,showCents)
            if nargin<2
                currency = '€';
                euroPrice = 1;
            end
            if ~exist('currency','var')
                currency = '€';
            end
            if ~exist('euroPrice','var')
                euroPrice = 1;
            end
            if ~exist('showCents','var')
                showCents = true;
            end
            out = string.empty;
            for n = 1:numel(obj)
                out(n) = string(gen.num2currency(obj(n).amountInEuros/euroPrice,currency,~showCents));
            end
            
        end
        
        function newAmount = plus(obj,moneyB)
            if isempty(obj)
                newAmount = moneyB;
            elseif isempty(moneyB)
                newAmount = obj;
            else
                newAmount = gen.money(obj.amountInEuros + moneyB.amountInEuros);
            end
        end
        
        function obj = uminus(obj)
            obj.amountInEuros = -obj.amountInEuros;
        end
        
        function newAmount = minus(obj,moneyB)
            newAmount = gen.money(obj.amountInEuros - moneyB.amountInEuros);
        end
        
        function newAmount  = mtimes(obj,factor)
            if ~obj.checkFactorNumeric(factor)
                newAmount = [];
                return
            end
            newAmount = gen.money(obj.amountInEuros * factor);
        end
        
        function newAmount  = mrdivide(obj,factor)
            if  isa(factor,'gen.money')
                newAmount = obj.amountInEuros./factor.amountInEuros;
            else
                newAmount = gen.money(obj.amountInEuros / factor);
            end
        end
        
        function newAmounts = sum(obj,dim,varargin)
            if nargin<2
                dim = 2;
            end
            newAmounts = gen.money(sum([obj.amountInEuros],dim,varargin{:}));
        end
        
        %         function obj = repmat(obj,varargin)
        %             TODO
        %         end
        
        function isequal = eq(obj,comparer)
            if isnumeric(comparer)
                isequal = obj.amountInEuros == comparer;
            elseif isa(comparer,'gen.money')
                isequal = obj.amountInEuros == comparer.amountInEuros;
            else
                fprintf('operation not implemented\n');
            end
        end
        
        function out = isnan(obj)
            out = isnan(obj.double);
        end
                
        function d = double(obj)
            d = obj.amountInEuros;
        end
        
        function out = lt(obj1,obj2)
            validateattributes(obj2,{'gen.money'},{});
            out = obj1.amountInEuros < obj2.amountInEuros;
        end
        function out = gt(obj1,obj2)
            validateattributes(obj2,{'gen.money'},{});
            out = obj1.amountInEuros > obj2.amountInEuros;
        end
        function out = le(obj1,obj2)
            validateattributes(obj2,{'gen.money'},{});
            out = obj1.amountInEuros <= obj2.amountInEuros;
        end
        function out = ge(obj1,obj2)
            validateattributes(obj2,{'gen.money'},{});
            out = obj1.amountInEuros >= obj2.amountInEuros;
        end
%         function out = num2cell(obj)
%             out = num2cell(obj.amountInEuros);
%         end
      
    end
    
    methods (Access = protected,Hidden)
        function displayImpl(obj,~,~)
            details(obj);            
            if ~ismatrix(obj)
                return
            end
            for y=1:size(obj,1)
                for x=1:size(obj,2)
                    disp(obj(y,x).asString);
                end
            end
        end
    end
    
    methods (Static,Access = protected)
        function ok = checkFactorNumeric(fac)
            ok = true;
            if  ~isnumeric(fac)
                fprintf('operation not implemented\nFactor must be numeric!\n');
                ok  = false;
            end
        end
    end
    
    methods (Static)
        function out = strIsLikeCurrencyStr(s)
           out = any(~cellfun('isempty',regexp(s,{'$' '€' 'EUR'}))); % TODO 
        end
        
        function obj = loadobj(S)
            if numel(S.amountInEuros)>1
                obj = arrayfun(@(a)gen.money(a, S.initialCurrency, 1/S.conversionRate),S.amountInEuros);% necessary for loading legacy objects
            else
                obj = S;
            end
        end
    end
end






