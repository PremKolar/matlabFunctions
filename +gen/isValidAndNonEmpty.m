function out = isValidAndNonEmpty(in)
    if ~isobject(in)
        out = false;
    else
        out = ~isempty(in) && isvalid(in);
    end
end