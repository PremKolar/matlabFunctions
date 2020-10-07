function out = datestrInfinitytoEmpty(in,format)
assert(ischar(format))
assert(isnumeric(in))
if isinf(in)
    out = [];
else
    out = datestr(in,format);
end
end