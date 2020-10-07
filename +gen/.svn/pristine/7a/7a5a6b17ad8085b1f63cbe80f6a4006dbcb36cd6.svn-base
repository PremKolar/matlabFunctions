function [curs,data] = fetchChecked(conn,query,leaveOpen)
    if nargin < 3
        leaveOpen = false;
    end
    curs = gen.execChecked(conn,query);
    out = fetch(curs);
    data = out.Data;
    if ~leaveOpen
        close(curs);
    end
end


