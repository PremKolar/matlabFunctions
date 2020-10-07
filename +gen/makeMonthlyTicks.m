% eg 01.01.2000 01.02.2000 ... 01.12.2345
function mticks = makeMonthlyTicks(d1,d2)
    a = datevec(d1);
    mticks = [];
    while datenum(a)<=d2
        mticks(end+1) = datenum(a); %#ok<AGROW>
        a(2)=a(2)+1;
    end
end