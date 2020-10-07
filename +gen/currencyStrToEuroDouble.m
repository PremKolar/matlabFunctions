function euros = currencyStrToEuroDouble(S,dollarRate)
    if iscell(S)
        S = S{1};
    end
    S = strrep(strip(S),',','.');
    currency = S(end);
    amount = str2double(S(1:end-1));
    switch currency
        case '$'
            rate = dollarRate;
        case '€'
            rate = 1;
        otherwise
            fprintf('assuming currency € for %s\n',S);
            rate = 1;
    end
    euros = amount / rate;
end