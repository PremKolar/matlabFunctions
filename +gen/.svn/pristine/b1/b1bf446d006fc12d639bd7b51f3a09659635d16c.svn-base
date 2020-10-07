% recursively set celleditcallbacks for all MTables within a ui structure
function setCallbackToAll(in,callbackCells)
    FN = fieldnames(in);
    for f=1:numel(FN)
        fn = FN{f};
        if ~isa(in.(fn),'MTable')
            gen.setCallbackToAll(in.(fn),callbackCells);
        else
            in.(fn).CellEditCallback = callbackCells;
        end
    end
end