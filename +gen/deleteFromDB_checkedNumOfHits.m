function [success,delCurs] = deleteFromDB_checkedNumOfHits(conn,delQuery,maxNumOfHits)
    success = true;
    selQuery = regexprep(delQuery,'DELETE FROM','SELECT * FROM','ignorecase');
    selCurs = gen.execChecked(conn,selQuery);
    data = fetch(selCurs);
    hits = size(data.Data,1);
    if hits>maxNumOfHits
        success = false;
        fprintf(2,'\nwarning:\naborting DELETE on database.\nmax number of entries to delete: %d\nfound %d entries\n\n',maxNumOfHits,hits);
        close(selCurs);
        return
    end
    %%   
    delCurs = gen.execChecked(conn,delQuery);    
     fprintf('\n\n');
    for k=1:hits
        fprintf('%s\t',data.Data{k,:});
        fprintf('\n');
    end
     fprintf('\n...deleted\n');
    close(delCurs);
end