%NK
function out = currency2num(in)
    
    if ~isempty(strfind(in,'€'))
        in = strrep(in,'.','');
        in = strrep(in,',','.');
        in = strrep(in,'€','');
        
    elseif ~isempty(strfind(in,'$'))
        in = strrep(in,',','');
        in = strrep(in,'$','');
        
    else
        error('not impled yet');
    end
    
    out = str2double(in);
    
end
