% U805233: January 23, 2020 - 16:48:57
function T = kickOutOtherClassesFromTable(T,classToKeep)
    validateattributes(T,{'table'},{})
    validateattributes(classToKeep,{'char'},{'row'})
    VN = T.Properties.VariableNames;
    kick = ~ismember(varfun(@class,T,'OutputFormat','cell'),classToKeep);
    if any(kick)
        kick = find(kick);
        for k=kick(:)'
            T.(k) = [];
        end
    end
end