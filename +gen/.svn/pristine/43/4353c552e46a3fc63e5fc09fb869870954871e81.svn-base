%NK
% TODO make this static function of gen.money
function out = num2currency(amount,currency,noCents)
    %     TODO
    if nargin<3
        noCents = 0;
    end
    
    if ~iscell(amount)
        if numel(amount)==1
            out = single(amount,currency,noCents);
            return
        else
            amount = num2cell(amount);
        end
    end
    
    out = cell(size(amount));
    for j=1:numel(out)
        out{j} = single(amount{j},currency,noCents);
    end
    
end

function out = single(amount,currency,noCents)
    
    switch currency
        case '$'
            curr = java.util.Locale.US;
        case '€'
            curr = java.util.Locale.GERMANY;
        otherwise
            out = strrep(single(amount,'€',noCents),'€',currency);
            return
    end
    
    
    
    j = java.text.NumberFormat.getCurrencyInstance(curr);
    if isnan(amount)
        out = '/';
    else
        out = char(j.format(amount));
    end
    if noCents
        out = regexprep(out,',\d{2}\D',' ');
        out = regexprep(out,'\.\d{2})?$','');
        if strcmp(out(1),'(')
            out(end+1) = ')';
        end
    end
end