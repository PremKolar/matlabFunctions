function out = sum(in,dim)
    if iscell(in)
        in(cellfun('isempty',in))={0};
        if ~all(cellfun(@isnumeric,in))
            error('');
        end
        tmp = sum(cell2mat(in),dim);
        out = num2cell(tmp);
        out(tmp==0)={''};
    elseif isnumeric(in)
        out = sum(in,dim);
    end
end