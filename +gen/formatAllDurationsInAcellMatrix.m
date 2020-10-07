function Cout = formatAllDurationsInAcellMatrix(C,Format)
    validateattributes(C,{'cell'},{})
    validateattributes(Format,{'char'},{'row'})
    Cout = C;
    isdur = cellfun(@isduration,C);
    Cout(isdur) = cellfun(@(d)applyFormat(d,Format),C(isdur),'UniformOutput',0);
end
function c = applyFormat(c,f)
    c.Format = f;
end