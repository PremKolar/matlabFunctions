
function deleteDataOnDBbyEqualityOfAfield(conn,field,fieldData,tableName)
    N=numel(fieldData);
    for n=1:N
        delQuery = ['DELETE FROM ' tableName ' WHERE ' gen.queryIsEqFrmt(field,fieldData{n})];       
        gen.deleteFromDB_checkedNumOfHits(conn,delQuery,1);         
    end
end