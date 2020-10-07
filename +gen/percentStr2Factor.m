function f = percentStr2Factor(s)
    s = strip(s);
    if strcmp(s(end),'%')
        f = 1 + str2double(s(1:end-1))/100; % eg 4% to 1.04
        return
    end
    f = str2double(s);
    if f<1 % eg 0.04 instead of 1.04
        f = f+1;
    end
end