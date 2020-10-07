% vector of 01.mm - dates between A and B
% this is faster than gen.monthlyvec
function V = monthsVector(from,till)
    [yA,mA] = datevec(from);
    [yB,mB] = datevec(till);
    numOfMonths = 12*(yB-yA) + (mB-mA)+1;
    V = datenum(repmat(yA,1,numOfMonths),mA:mA+numOfMonths-1,ones(1,numOfMonths));
end