function Cout = formatAlldatetimesInAcellMatrix(C,Format)
    validateattributes(C,{'cell'},{})
    validateattributes(Format,{'char'},{'row'})
    Cout = C;
    isDT = cellfun(@isdatetime,C);
    Cout(isDT) = cellfun(@(d)applyFormat(d,Format),C(isDT),'UniformOutput',0);
end
function c = applyFormat(c,f)
    c.Format = f;
end