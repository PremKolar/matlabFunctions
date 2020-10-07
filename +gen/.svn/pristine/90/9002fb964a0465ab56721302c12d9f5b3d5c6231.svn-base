% NK
function out = linInterpFromLeftRightNeighbors(t,v,tqueries,allowForExactHits)
    if nargin<3
        allowForExactHits = false;
    end
    flag = isnan(t) | isnan(v);
    t(flag) = nan;
    [~,ii] = gen.getBothNeighborsLeftRight(t,tqueries,allowForExactHits);
    out = nan(size(tqueries));
    
    for j=find(~isnan(ii(1,:)))
        if allowForExactHits && diff(ii(:,j),1)==0
            out(j) = v(ii(1,j)); % either one
            continue
        end
        a = diff(v(ii(:,j)))/diff(t(ii(:,j))); % steigung
        b = v(ii(1,j)) - a*t(ii(1,j)); % offset
        out(j) = a * tqueries(j) + b;
    end
end