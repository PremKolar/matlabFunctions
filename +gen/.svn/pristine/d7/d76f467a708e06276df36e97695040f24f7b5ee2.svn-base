% Current date   = March 09, 2020
% Matlab version = 9.6.0.1072779 (R2019a)
% User name      = U805233
classdef quration < matlab.mixin.CustomDisplay
    
    properties (SetAccess = protected)
        days (1,1) double = nan
    end
    
    properties (Dependent)
        ISO8601
    end
    
    properties (Access = protected)
        dispFormat (1,:) char = '%.5f d'
    end
    
%     properties (Dependent)
%         years
%         months
%         weeks
%         hours
%         minutes
%         seconds
%     end
    
    methods
        function obj = quration(varargin)
            switch numel(varargin)
                case 1
                    if isa(varargin{1},'gen.quration')
                        obj = varargin{1};
                    elseif isnumeric(varargin{1}) % from datenum
                        if numel(varargin{1})>1
                            obj = arrayfun(@(x)gen.quration(x),varargin{1});
                        else
                            obj.setDays(varargin{1});
                        end
                    elseif isduration(varargin{1})
                        obj.setDays(days(varargin{1}));
                    else
                        obj.notImpledError();
                    end
                case 3
                    obj.setHoursMinsSecs(varargin{:}); % from hh,mm,ss
                otherwise
                    error('wrong number of inputs')
            end
        end
        
        function obj = setDays(obj,n)
            obj.days = n;
            %             [obj.Year,obj.Month,obj.Day,obj.Hour,obj.Minute,obj.Second] = datevec(n);
        end
        
        function obj = setHoursMinsSecs(obj,h,m,s)
            obj.days = (h + m/60 + s/60/60)/24;
        end
        
        
        function out = get.ISO8601(obj)
            if isnan(obj.days)
                out = 'NULL';
                return
            end
            TODO
            %             https://www.digi.com/resources/documentation/digidocs/90001437-13/reference/r_iso_8601_duration_format.htm
            %             out = sprintf('%s%+03d',datestr(obj.days,'yyyy-mm-ddTHH:MM:SS'),tz);
        end
        
        
        function [out,idx] = min(obj,varargin)
            [out,idx] = min([obj.days],varargin{:});
        end
        
        function [out,idx] = max(obj,varargin)
            [out,idx] = max([obj.days],varargin{:});
        end
        
        
        
        function out = datestr(obj,varargin)
            out =  datestr(obj.days,varargin{:});
        end
        
        function out = datenum(obj)
            out =  [obj.days];
        end
        
        function varargout = datevec(obj)
            varargout = num2cell(datevec([obj.days]));
        end
        
        
        function out = duration(obj)
            out = arrayfun(@(x)duration(floor(x.hours),floor(x.minutes),x.seconds),obj);
        end
        
        
        function out = diff(obj,varargin)
            out =  diff([obj.days],varargin{:});
        end
        
        
        function out = isnan(obj)
            out = isnan(obj.days);
        end
        
        
        function out = plus(obj,obj2)
            if isa(obj2,'gen.quration')
                out = obj.setDays(obj.days + obj2.days);
            elseif isa(obj2,'gen.qatetime')
                out = gen.qatetime(obj2.num + obj.days);
            elseif isnumeric(obj2)
                out = obj.setDays(obj.days + obj2);
            elseif isduration(obj2)
                out = obj.setDays(obj.days + days(obj2)); %#ok<CPROPLC>
            else
                obj.notImpledError();
            end
        end
        
        
        function out = minus(obj,obj2)
            if isa(obj2,'gen.quration')
                out = obj.setDays(obj.days - obj2.days);
            elseif isa(obj2,'gen.qatetime')
                out = gen.qatetime(obj2.num - obj.days);
            elseif isnumeric(obj2)
                out = obj.setDays(obj.days - obj2);
            elseif isduration(obj2)
                obj.setDays(obj.days - days(obj2)); %#ok<CPROPLC>
            else
                obj.notImpledError();
            end
        end
        
        function out = lt(obj,obj2)
            if isa(obj2,'gen.quration')
                out = [obj.days] < [obj2.days];
            elseif isnumeric(obj2)
                out = [obj.days] < obj2;
            else
                obj.notImpledError();
            end
        end
        
        
        function out = le(obj,obj2)
            if isa(obj2,'gen.quration')
                out = [obj.days] <= [obj2.days];
            elseif isnumeric(obj2)
                out = [obj.days] <= obj2;
            else
                obj.notImpledError();
            end
        end
        
        function out = gt(obj,obj2)
            if isa(obj2,'gen.quration')
                out = [obj.days] > [obj2.days];
            elseif isnumeric(obj2)
                out = [obj.days] > obj2;
            else
                obj.notImpledError();
            end
        end
        
        function out = ge(obj,obj2)
            if isa(obj2,'gen.quration')
                out = [obj.days] >= [obj2.days];
            elseif isnumeric(obj2)
                out = [obj.days] >= obj2;
            else
                obj.notImpledError();
            end
        end
        
        function out = eq(obj,obj2)
            if isa(obj2,'gen.quration')
                out = [obj.days] == [obj2.days];
            elseif isnumeric(obj2)
                out = [obj.days] == [obj2];
            else
                obj.notImpledError();
            end
        end
        
        function out = ne(obj,obj2)
            if isa(obj2,'gen.quration')
                out = [obj.days] ~= [obj2.days];
            elseif isnumeric(obj2)
                out = [obj.days] ~= obj2;
            else
                obj.notImpledError();
            end
        end
        
        % @overwrite
        function S = toStruct(obj,~,~)
            S = struct;
            S.type = 'duration';
            S.days = obj.days;
        end
        
        
    end
    
    methods (Access = protected)
        
        
        function notImpledError(~)
            error('not yet implemented')
        end
    end
    
    methods (Sealed)
        
    end
    
    methods (Static)
        
    end
end