function date = addAMonth(date)
    switch class(date)
        case 'double'
            [y,m,d] = datevec(date);
            date = datenum(y,m+1,d);
        case 'datetime'
            date = datetime(date.Year,date.Month+1,date.Day);
        otherwise
            error('wrong format')
    end
end