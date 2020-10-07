% NK
% datas must be columnvectors
% NK: critical edit. hope this still works
function [out,ii] = getBothNeighborsLeftRight(data,querypoints,allowForExactHits)
    if nargin<3
        allowForExactHits = false;
    end
    if size(data,1)==1
        data = data';
    end
    validateattributes(data,{'double'},{'2d'})
    validateattributes(querypoints,{'double'},{'vector'})
    
    ii  = nan(2,numel(querypoints));
    mdiff = (data-querypoints(:)');
    
    % right
    tmp = mdiff;
    if allowForExactHits
        tmp(mdiff<0)=inf;
    else
        tmp(mdiff<=0)=inf;
    end
    fail=all(isnan(tmp)|isinf(tmp),1);
    [~,ii(2,:)] = min(tmp,[],1,'omitnan');
    
    % left
    tmp = mdiff;
    if allowForExactHits
        tmp(mdiff>0)=-inf;
    else
        tmp(mdiff>=0)=-inf;
    end
    fail=fail|all(isnan(tmp)|isinf(tmp),1);
    [~,ii(1,:)] = max(tmp,[],1,'omitnan');
    
    % values
    out = data(ii);
    
    % nan out failed ones
    out(:,fail) = nan;
    ii(:,fail) = nan;
    
    if ~allowForExactHits
        assert(all(out(1,:)~=out(2,:) | fail));
    end
end