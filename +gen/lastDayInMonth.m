function out = lastDayInMonth(d)
    switch class(d)
        case 'double'
            [Y,M,~] = datevec(d);
            out = datenum(Y,M+1,1)-1;
        case 'datetime'
            out = datetime(d.Year,d.Month+1,0);
        otherwise
            error('wroing format')
    end
    
    
end