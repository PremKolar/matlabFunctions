% find for each index of input grid the nearest index in output grid
% nkpmn@web.de
function [idxlin,idxY,idxX] = binDownGlobalMap(inLat,inLon,outLat,outLon)
    inLalo = wrapTo360(inLon(:)) + 1i*inLat(:);
    outLalo = wrapTo360(outLon(:)) + 1i*outLat(:);
    idxlin = nan(size(inLalo));
    lims = thread_distro(12,numel(inLalo));
    %%
    spmd
        T = disp_progress('init','allocating indices to nearest bin');
        for ii = lims(labindex,1):lims(labindex,2)
            T = disp_progress('show',T,diff(lims(labindex,:)),1000);
            [minA,minAidx] = min(abs(inLalo(ii)-outLalo)) ;
            [minB,minBidx] = min(abs(inLalo(ii)-outLalo + 360)) ;
            if minA < minB
                idxlin(ii) = minAidx;
            else
                idxlin(ii) = minBidx; % crossing 360 meridian
            end
        end
        idxx = gop(@horzcat,idxlin,1);
    end
    idxx = idxx{1};
    idxlin = nansum(idxx,2);
    [idxY,idxX] = raise_1d_to_2d(size(inLat,1));
end
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% split number of loop iterations into chunks for spmd
% from-to array = thread_distro(threads,steps)
function lims = thread_distro(threads,steps)
    lims = nan(threads,2);
    distemp = round(linspace(1,steps+1,threads+1));
    lims(:,1) = distemp(1:end-1);
    lims(:,2) = lims(:,1)+diff(distemp)'-1;
    if threads>steps
        lims = thread_distro(steps,steps);
        lims(end+1:threads,:) = repmat([1 0],threads-steps,1);
    end
end
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% get 2d-coordinate pair from 1d-coordinate.
function [y,x] = raise_1d_to_2d(Y,x1d)
    if isempty(x1d)
        y=[];x=[];return
    end
    x=(ceil((double(x1d))/double(Y)));
    y=(x1d - (x-1)*Y);
end
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%