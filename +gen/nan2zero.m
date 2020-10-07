function in = nan2zero(in)
    in(isnan(in)) = 0;
end