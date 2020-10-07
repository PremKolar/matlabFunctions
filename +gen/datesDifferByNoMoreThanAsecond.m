% Current date   = May 05, 2020
% Matlab version = 9.6.0.1072779 (R2019a)
% User name      = U805233
function ok = datesDifferByNoMoreThanAsecond(dates)
    validateattributes(dates,{'datetime'},{'vector'})
    ok = all(round(seconds(diff(dates,1))) == 0);
end