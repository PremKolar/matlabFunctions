function addLastXcolsToMTable(M,x)
   
    cn = M.ColumnName;
    ch = M.CellHighlight;
    cc = M.CellCombo;
    
    M.Data(:,end+1:end+x) = cell(size(M.Data,1),x);
    M.ColumnName    = cn([1:end end-x+1:end]);
    M.CellHighlight = [ ch ch(:,end-x+1:end)];
    M.CellCombo     = [ cc cc(:,end-x+1:end)];
    
end