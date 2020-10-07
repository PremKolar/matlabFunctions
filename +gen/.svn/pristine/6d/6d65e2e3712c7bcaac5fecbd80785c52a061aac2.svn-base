% NK
function [v,aorb] = MatlabVersion()
    tmp = regexprep(version,'^.*\(R','');
    v = str2double(regexprep(tmp,'[abcd]\).*',''));
    aorb = regexprep(regexprep(tmp,'\d',''),'\).*','');
end