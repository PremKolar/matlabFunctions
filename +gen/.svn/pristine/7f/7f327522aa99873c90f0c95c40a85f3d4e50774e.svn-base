function yes = isDateLikeFormat(dateStr,frmt)
    yes = true;
    try
        if ~strcmp(dateStr,datestr(datenum(dateStr,frmt),frmt))
            yes = false;
        end
    catch
        yes=false;
    end
end