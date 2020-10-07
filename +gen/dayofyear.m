
function out = dayofyear(d)
    a = datevec(d);
    b = a;
    b(2:end) = 0;
    out = datenum(a)-datenum(b);
end
