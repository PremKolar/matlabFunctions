function T = appendRealColumnNamesToTable(T,colNames)
    T.Properties.Description = ['Column Names:' sprintf('\t%s',colNames{:})];
end