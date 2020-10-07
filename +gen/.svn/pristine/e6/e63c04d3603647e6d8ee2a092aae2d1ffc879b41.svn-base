function Cout = formatAllqatetimesInAcellMatrix(C,Format)
    validateattributes(C,{'cell'},{})
    validateattributes(Format,{'char'},{'row'})
    Cout = C;
    isQT = cellfun(@(x)isa(x,'gen.qatetime'),C);
    Cout(isQT) = cellfun(@(d)applyFormat(d,Format),C(isQT),'UniformOutput',0);
end
function c = applyFormat(c,f)
    c = datestr(c,f);
end