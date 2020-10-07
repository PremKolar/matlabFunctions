function T = setValueInCellTable(T,key,value)
    [~,X] = size(T);
    for x=1:2:X-1
        jj=~cellfun('isempty',strfind(T(:,x),key));
        if sum(jj)>1
            jj = strcmp(T(:,x),key); % more explicit
            if sum(jj)>1
                error('ambiguities')
            end
            break
        elseif sum(jj)==1
            break
        end
    end
    y = find(jj);
    if isempty(y)
        error('not found %s',key)
    else
        T{y,x+1} = value; % found
    end
end