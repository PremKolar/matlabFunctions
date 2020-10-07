% NK
function from = monthlyvec(from, till)
    if from>till
        return
    end
    [Y,M,D] = datevec(from);
    from = [from gen.monthlyvec(datenum(Y,M+1,D),till)];
end