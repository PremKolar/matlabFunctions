
function str = firstLetterUp(str)
    validateattributes(str,{'char'},{});
    %     str = lower(str); % allow for eg "LLP"
    idx = regexp([' ' str],'(?<=\s+)\S','start')-1;
    str(idx) = upper(str(idx));
end