% Current date   = November 21, 2019
% Matlab version = 9.6.0.1072779 (R2019a)
% User name      = U805233
classdef qatetime < matlab.mixin.CustomDisplay
    
    properties (SetAccess = protected)
        num (1,1) double = nan
    end
    
    properties (Dependent)
        ISO8601
    end
    
    properties
        timezone (1,1) int8 {mustBeGreaterThanOrEqual(timezone,-12),mustBeLessThanOrEqual(timezone,12)} = 1
        daylightSavings (1,1) logical = true
    end
    properties (Access = protected)
        dispFormat (1,:) char = 'dd.mm.yyyy - HH:MM:SS'
    end
    
    properties (Dependent)
        year
        month
        day
        hour
        minute
        second
    end
    
    
    
    
    methods
        function obj = qatetime(varargin)
            switch numel(varargin)
                case 1
                    if isa(varargin{1},'gen.qatetime')
                        obj = varargin{1};
                    elseif isnumeric(varargin{1}) % from datenum
                        if numel(varargin{1})>1
                            obj = arrayfun(@(x)gen.qatetime(x),varargin{1});
                        else
                            obj = obj.setNum(varargin{1});
                        end
                    elseif isdatetime(varargin{1})
                        obj = obj.setNum(datenum(varargin{1}));
                    else
                        obj = obj.notImpledError();
                    end
                case 2 % with format
                    if ~isempty(varargin{1})
                        obj = obj.setNum(datenum(varargin{1},varargin{2}));
                    else
                        obj = obj.setNum(datenum(nan));
                    end
                case 3
                    if ischar(varargin{2}) && strcmp(varargin{2},'InputFormat')
                        obj = obj.setNum(datenum(datetime(varargin{:}))); % slow
                    else
                        obj = obj.setNum(datenum(varargin{:})); % from Y,M,D
                    end
                otherwise
                    error('wrong number of inputs')
            end
        end
        
        function obj = setNum(obj,n)
            obj.num = n;
            %             [obj.Year,obj.Month,obj.Day,obj.Hour,obj.Minute,obj.Second] = datevec(n);
        end
        
        
        
        function out = get.ISO8601(obj)
            if isnan(obj.num)
                out = 'NULL';
                return
            end
            tz = obj.timezone;
            if obj.daylightSavings && obj.isInDaylightSaving(obj.num)
                tz = tz+1;
            end
            out = sprintf('%s%+03d',datestr(obj.num,'yyyy-mm-ddTHH:MM:SS'),tz);
        end
        
        
        function [out,idx] = min(obj,varargin)
            [out,idx] = min([obj.num],varargin{:});
        end
        
        function [out,idx] = max(obj,varargin)
            [out,idx] = max([obj.num],varargin{:});
        end
        
        
        
        function out = datestr(obj,varargin)
            out =  datestr(obj.num,varargin{:});
        end
        
        function out = datenum(obj)
            out =  [obj.num];
        end
        
        function varargout = datevec(obj)
            varargout = num2cell(datevec([obj.num]));
        end
        
        
        function out = datetime(obj)
            out = arrayfun(@(x)datetime(x.num,'ConvertFrom','datenum'),obj);
        end
        
        
        function out = diff(obj,varargin)
            out =  diff([obj.num],varargin{:});
        end
        
        
        function out = isnat(obj)
            out = isnan([obj.num]);
        end
        function out = isnan(obj)
            out = obj.isnat;
        end
        
        
        function out = plus(obj,obj2)
            if isa(obj2,'gen.quration')
                out = gen.qatetime(obj.num + obj2.days);
            elseif isnumeric(obj2)
                out = gen.qatetime(obj.num + obj2);
            elseif isduration(obj2)
                out = gen.qatetime(obj.num + days(obj2));
            else
                obj.notImpledError();
            end
        end
        
        function out = minus(obj,obj2)
            if isa(obj2,'gen.qatetime')
                out = gen.quration(24*([obj.num] - [obj2.num]),0,0);
            elseif isa(obj2,'gen.quration')
                out = gen.qatetime(obj.num - obj2.days);
            elseif isnumeric(obj2)
                out = gen.qatetime(obj.num - obj2);
            elseif isduration(obj2)
                out = gen.qatetime(obj.num - days(obj2));
            else
                obj.notImpledError();
            end
        end
        
        function out = lt(obj,obj2)
            if isa(obj2,'gen.qatetime')
                out = [obj.num] < [obj2.num];
            elseif isnumeric(obj2)
                out = [obj.num] < obj2;
            else
                obj.notImpledError();
            end
        end
        
        
        function out = le(obj,obj2)
            if isa(obj2,'gen.qatetime')
                out = [obj.num] <= [obj2.num];
            elseif isnumeric(obj2)
                out = [obj.num] <= obj2;
            else
                obj.notImpledError();
            end
        end
        
        function out = gt(obj,obj2)
            if isa(obj2,'gen.qatetime')
                out = [obj.num] > [obj2.num];
            elseif isnumeric(obj2)
                out = [obj.num] > obj2;
            else
                obj.notImpledError();
            end
        end
        
        function out = ge(obj,obj2)
            if isa(obj2,'gen.qatetime')
                out = [obj.num] >= [obj2.num];
            elseif isnumeric(obj2)
                out = [obj.num] >= obj2;
            else
                obj.notImpledError();
            end
        end
        
        function out = eq(obj,obj2)
            if isa(obj2,'gen.qatetime')
                out = [obj.num] == [obj2.num];
            elseif isnumeric(obj2)
                out = [obj.num] == [obj2];
            else
                obj.notImpledError();
            end
        end
        
        function out = ne(obj,obj2)
            if isa(obj2,'gen.qatetime')
                out = [obj.num] ~= [obj2.num];
            elseif isnumeric(obj2)
                out = [obj.num] ~= obj2;
            else
                obj.notImpledError();
            end
        end
        
        function out = get.year(obj)
            [out,~] = datevec(obj.num);
        end
        function out = get.month(obj)
            [~,out] = datevec(obj.num);
        end
        function out = get.day(obj)
            [~,~,out] = datevec(obj.num);
        end
        function out = get.hour(obj)
            [~,~,~,out] = datevec(obj.num);
        end
        function out = get.minute(obj)
            [~,~,~,~,out] = datevec(obj.num);
        end
        function out = get.second(obj)
            [~,~,~,~,~,out] = datevec(obj.num);
        end
        function out = addSeconds(obj,s)
           out = gen.qatetime(obj.num + s/24/60/60); 
        end
        
        %
        %
        %         function disp(obj)
        %             details(obj)
        %             %             for k=1:numel(obj)
        %             %                 if ~isnan(obj(k).num)
        %             %                     disp(datestr(obj(k).num,obj(k).dispFormat))
        %             %                 else
        %             %                     disp('NULL')
        %             %                 end
        %             %             end
        %         end
        %
        
        % @overwrite
        function S = toStruct(obj,~,~)
            S = struct;
            S.type = 'datetime';
            S.ISO8601 = obj.ISO8601;
            S.MLdays = obj.num;
        end
    end
    
    methods (Access = protected,Hidden)
        
        function displayImpl(obj,a1,a2)
            
        end
        
        %         function displayNonScalarObject(objAry)
        %
        %         end
        %
        %         function displayScalarObject(obj)
        %             details(obj)
        %         end
        %
        %         function getHeader(obj)
        %             disp(obj.datestr)
        %         end
        
        
        
        function notImpledError(~)
            error('not yet implemented')
        end
    end
    
    methods (Sealed)
        
    end
    
    methods (Static)
        function is = isInDaylightSaving(date)
            [~,m,d] = datevec(date);
            if (m>3 || (m==3 && d>=29)) && (m<10 || (m==10 && d<=25))
                is = true;
            else
                is = false;
            end
        end
    end
end