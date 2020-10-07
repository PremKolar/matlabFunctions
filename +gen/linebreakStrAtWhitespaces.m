% break up a string into lines with each line being no longer than maxlen
function out = linebreakStrAtWhitespaces(s,maxlen)
    %% prep (if words longer than maxlen)
    sstemp = strsplit(s);
    ss=cell(1,0);
    for j=1:numel(sstemp)
        ssj = sstemp{j};
        if length(ssj)>maxlen
            while ~isempty(ssj)
                ss = [ss ssj(1:min([maxlen length(ssj)]))]; %#ok<*AGROW>
                ssj(1:min([maxlen length(ssj)])) = [];
            end
        else
            ss = [ss ssj];
        end
    end
    %% put 2g4
    out = '';
    while numel(ss)>0
        line = '';
        while numel(ss)>0 && length(line)+length(ss{1})<=maxlen
            line = [line ss{1} ' '];
            ss(1) = [];
        end
        out = [out line(1:end-1) '\n'];
    end    
    out(end-1:end) = [];    
    %% check
%     sprintf(out)
end