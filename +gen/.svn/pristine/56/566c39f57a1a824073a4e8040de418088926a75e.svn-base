% NK
function Tout = vertcat2tables(T1,T2,dummyvalue)
    validateattributes(T1,{'table'},{})
    validateattributes(T2,{'table'},{})
    assert(numel(dummyvalue)==1)
    
    A = [T1.Properties.VariableNames; table2cell(T1)];
    B = [T2.Properties.VariableNames; table2cell(T2)];
    
    Tout = gen.vertcat2matricesOfDifferentWidth(A,B,{dummyvalue},true);
    
    Tout = cell2table(Tout(2:end,:),'VariableNames',Tout(1,:));
end
