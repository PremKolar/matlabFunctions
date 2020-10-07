function [curs] = execChecked(conn,query)

curs = exec(conn,query);

if ~isempty(curs.Message)
    problem(curs);
end
end

function problem(curs)
fprintf(2,'\nhaving problems with DB connection!\n');
fprintf(2,'message: %s\n\n',curs.Message);
error('aborting!');
end


