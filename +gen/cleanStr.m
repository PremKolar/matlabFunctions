% NK
function s = cleanStr(s,withCapWords,withoutUnderScores,toKeepExtra)
    validateattributes(s,{'char','cell'},{'vector'});
    
    if ischar(s)
        s={s};
    end
    if nargin<2
        withCapWords = false;
    end
    if nargin<3
        withoutUnderScores = false;
    end
    
    s(cellfun(@isempty,s)) = {''};
    
    s = strip(regexprep(s,'[\s-]+',' '));
    s = regexprep(s,'\s*',' ');
    if withoutUnderScores
        s = regexprep(s,'_','');
    end
    
    toKeep = 'a-zA-Z0-9_ ';
    if nargin>=4
        toKeep = [toKeep toKeepExtra];
    end
    s = regexprep(s,sprintf('[^%s]',toKeep),'');
    
    if withCapWords
        for j=1:numel(s)
            idx = regexp([' ' s{j}],'(?<=\s+)\S','start')-1;
            s{j}(idx) = upper(s{j}(idx));
        end
    else
        s=lower(s);
    end
    s = strrep(s,' ','');
    
    
    hasnum = cellfun(@isempty,regexp(s,'[a-zA-Z]', 'once'));
    if any(hasnum) % fully numeric eg. 123
        s(hasnum) = cellfun(@(x) ['F_' x],s(hasnum),'UniformOutput',false)  ;
    end
    
    if numel(s)==1
        s=s{1};
    end
end