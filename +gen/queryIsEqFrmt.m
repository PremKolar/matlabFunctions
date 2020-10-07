% format input for DB where-clause expressions
% f: field
% s: value
function q = queryIsEqFrmt(f, s)
validateattributes(f,{'char'},{});
f = [' ' f];
if iscell(s) % if is equal to any of...
    q = sprintf([f ' = ''%s'' OR '],s{:});
    q = q(1:end-3);
else
    if isempty(s) || strcmp(s,'NULL')
        q = [f ' IS NULL '];
    elseif isnumeric(s)
        q = [f ' = ' num2str(s) ];
    elseif strcmp(strtrim(s),'*') % any entry
        q = [ '(' f ' LIKE ''%'' OR ' f ' IS NULL )'];
    else
        q = [f ' = ''' s ''''];
    end
    
end
end