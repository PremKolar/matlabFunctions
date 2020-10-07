% N.K. 18/04/10
% make struct from cell array with given fieldnames. struct length is 1.
% numel of data under each field is Y
function  s = cell2struct2(data,columnNames)
    
    [Y,X] = size(data); %#ok<ASGLU>
    N = numel(columnNames);
    s = struct;
    
    if X~=N
        data = data';
    end
    
    for i = 1:N
        s.(columnNames{i}) = data(:,i) ;
    end
    
end