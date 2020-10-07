function dout = otherDateOfSameYear(din,newmonth,newday)
    y = gen.year(din);
    dout = datenum(y,newmonth,newday);    
end