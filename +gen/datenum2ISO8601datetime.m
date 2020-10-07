% U805233: February 21, 2020 - 12:45:19
function out = datenum2ISO8601datetime(in,useNaTforFailures,frmt)
    if nargin<2
        useNaTforFailures = false;
    end
    frmt = 'yyyy-MM-dd''T''HH:mm:ssZZZZZ';
    TZ = 'local';
    dt = @(x)datetime(x,'ConvertFrom','datenum','Format',frmt,'TimeZone',TZ);
    
    try
        switch class(in)
            case 'datetime'
                out = in;
                out.Format = frmt;
                out.TimeZone = TZ;
            case 'char'
                assert(nargin>=3)
                out = dt(datenum(in,frmt));
            case 'double'
                assert(isscalar(in))
                out = dt(in);
            case 'duration'
                out = days(in); % TODO
            otherwise
                error('wrong format')
        end
    catch me
        if useNaTforFailures
            out = NaT;
        else
            rethrow(me);
        end
    end
end



