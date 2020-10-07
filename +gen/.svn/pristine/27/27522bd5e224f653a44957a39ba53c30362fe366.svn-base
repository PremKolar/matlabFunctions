% U805233: February 21, 2020 - 12:45:19
function [dn,dt] = ISO8601datetime2datenum(in,timezone)
    if nargin<2
        timezone = 'local';
    end
    validateattributes(in,{'char'},{'row'})
    dt = datetime(in,'InputFormat','yyyy-MM-dd''T''HH:mm:ssZZZZZ','TimeZone',timezone);
    dn = datenum(dt);
end