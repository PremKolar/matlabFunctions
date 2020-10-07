function [T, newVarNames] = MTable2table(M)
%     newVarNames = regexprep(M.ColumnName,'[^a-zA-Z0-9_]','');
    newVarNames = gen.cleanStr(M.ColumnName,1);
    T = cell2table(M.Data,'VariableNames',newVarNames);
end