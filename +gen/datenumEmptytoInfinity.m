function out = datenumEmptytoInfinity(in,format)
assert(ischar(format))
assert(ischar(in) || isnumeric(in))
if isempty(in)
    out = inf;
else
    out = datenum(in,format);
end
end