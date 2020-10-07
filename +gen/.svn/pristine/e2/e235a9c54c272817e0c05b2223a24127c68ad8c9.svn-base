% NK
% delete duplicate entries in a DB table. duplicate meaning, all fields are equal
function deleteDuplicateRowsOnDBtable(conn,tableName)
    assert(isa(conn,'database.jdbc.connection'));
    % get column names
    [~,colNames] = gen.fetchChecked(conn,sprintf('SELECT COLUMN_NAME FROM ALL_TAB_COLUMNS WHERE TABLE_NAME = ''%s''',tableName));
    columnsCommaSeperated = sprintf('%s,',colNames{:});
    % look at duplicates
    selectQuery = sprintf('Select * FROM %s WHERE ROWID NOT IN ( SELECT MAX(ROWID) FROM %s GROUP BY %s )',tableName,tableName,columnsCommaSeperated(1:end-1));
    [~,selectOutput] = gen.fetchChecked(conn,selectQuery);
    if strcmp('No Data',selectOutput)
        fprintf('nothing found!\n')
        return
    end
    answer = questdlg(sprintf('delete %d entries from %s?',numel(selectOutput),tableName),'found duplicates!','yes','no','no');
    if ~strcmp('yes',answer)
        return
    end
    % delete duplicates (leave one for each)
    delQuery = sprintf('DELETE FROM %s WHERE ROWID NOT IN ( SELECT MAX(ROWID) FROM %s GROUP BY %s )',tableName,tableName,columnsCommaSeperated(1:end-1));
    gen.fetchChecked(conn,delQuery);
    disp('done');
end

