% NK
% todo share this on mathworks
function ticks = declutterticks(ticks,fac,keepValue)
    narginchk(2,3)
    ticks = ticks(:)';
    
    if nargin<3
        keepValue = [];
    end
    keepValue = keepValue(:);
    
    ticks = unique(ticks);
    thresh = (max(ticks)-min(ticks))/fac;
    tooTightIndcs = find([false diff(ticks(1:end-1))<thresh]);
    if ~isempty(keepValue)
        tooTightIndcs(any(find(any(ticks==keepValue,1))'==tooTightIndcs,1))=[];
    end
    if ~isempty(tooTightIndcs)
        ticks(tooTightIndcs(1:2:end))=[];
        ticks = gen.declutterticks(ticks,fac,keepValue);
    end
end
