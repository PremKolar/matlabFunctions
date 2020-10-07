
function [out] = daysLeftInYear(d)
        out = gen.daysInYear(gen.year(d)) - gen.dayofyear(d);
end


