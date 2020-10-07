% NK some formatting methods
classdef Format   
    methods (Static)      
        
        function C = prcnt(C)
            f=@(c) sprintf('%.02f %%',c);
            if iscell(C)
                C = cellfun(@(c)f(c), C,'UniformOutput',false);
            else
                C=f(C);
            end
        end
        
        function C = hours(C)
            f=@(c) sprintf('%.1fH',c);
            if iscell(C)
                C = cellfun(@(c)f(c), C,'UniformOutput',false);
            else
                C=f(C);
            end
        end
        
        function C = euros(C)
            f=@(c)gen.num2currency(c,'€',1);
            if iscell(C)
                C = cellfun(@(c)f(c), C,'UniformOutput',false);
            else
                C=f(C);
            end
        end
        
        function C = dollars(C,rate)
            if nargin<2
                rate=1;
            end
            f=@(x) gen.num2currency(x*rate,'$',1);
            if iscell(C)
                C(~gen.isempty(C)) = cellfun(@(c)f(c), C(~gen.isempty(C)),'UniformOutput',false);
            else
                C=f(C);
            end
        end
        
        function C = prcnt2Num(C)
            f=@(x)str2double(regexprep(x,'%',''))/100;
            if iscell(C)
                C = cellfun(@(c)f(c), C,'UniformOutput',false);
            else
                C=f(C);
            end
        end
        
        function C = any2Num(C)
            if iscell(C)
                C(~gen.isempty(C)) = cellfun(@(c)gen.currency2num(c), C(~gen.isempty(C)),'UniformOutput',false);
            else
                C=gen.currency2num(C);
            end
        end        
        
    end 
    
end