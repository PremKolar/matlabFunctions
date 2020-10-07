classdef DatePicker < handle
    
    properties (SetAccess = immutable)
        ui = fmtOOP.interfaces.UItools
    end
    
    properties (SetAccess = protected)
        fig
        dateFormat = 'dd.mm.yyyy'
        chosenDateNum double
        chosenDateTimedate datetime
    end
    
    
    methods
        function obj = DatePicker()
            
        end
        
        function prompt(obj,defAnswer)
            prompt = {'enter date!'};
            dlg_title = 'date picker';
            num_lines = 1;
            if nargin>1
                defaultans = {defAnswer};
            else
                defaultans = {obj.dateFormat};
            end
            out = inputdlg(prompt,dlg_title,num_lines,defaultans);
            answer = char(out);
            if ~obj.checkAnswer(answer)
                warndlg('invalid input. try again!')
                obj.prompt();
            else
                if isempty(answer)
                    return
                end
                obj.chosenDateNum      = datenum(answer,obj.dateFormat) ;
                obj.chosenDateTimedate = datetime(obj.chosenDateNum,'convertFrom','datenum');
            end
        end
        
        function setDateFormat(obj,value)
            validateattributes(value,{'char'},{'row'})
            if obj.checkDateFormat(value)
                obj.dateFormat = value;
            else
                warning('invalid format!')
            end
        end
        
        
        
        
    end
    
    methods (Access = protected)
        function ok = checkAnswer(obj,answer)
            ok = true;
            try
                warning off
                datenum(answer,obj.dateFormat);
                warning on
            catch
                ok = false;
            end
        end
    end
    
    methods (Static)
        function ok = checkDateFormat(in)
            try
                assert(datenum(datestr(73000,in),in)==73000)
                ok = true;
            catch
                ok = false;
            end
        end
    end
    
end