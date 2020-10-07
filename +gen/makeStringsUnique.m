% NK
%
% eg
%
% in =
% 1×7 cell array
% 'a'    'b'    'a'    'c'    'c'    'a'    'd'
% out =
% 1×7 cell array
% 'a_001'    'b'    'a_002'    'c_001'    'c_002'    'a_003'    'd'

function out = makeStringsUnique(in,rename1st)
    if nargin<2
        rename1st = false;
    end
    out = in;
    [uniq,~,ib] = unique(in);
    [c,~] = histcounts(ib,.5:1:numel(uniq)+.5);
    
    for j = 1:numel(uniq)
        if c(j)<2
            continue
        end
        toEditIndcs = find(ib==j);
        k_1 = ~rename1st+1;
        for k=k_1:c(j)
            out{toEditIndcs(k)} = sprintf('%s_%03d',out{toEditIndcs(k)},k);
        end
    end
end