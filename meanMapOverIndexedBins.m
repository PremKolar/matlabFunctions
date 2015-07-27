% nkpmn@web.de
% idx(j) = respective index of nearest bin (mapBinned) of value of mapIn at index j
function mapBinned = meanMapOverIndexedBins(mapIn,idx,Y,X,threads)
    
    %% init
    mapCount  = zeros(Y*X,1);
    mapBinned = zeros(Y*X,1);
    lims = thread_distro(threads,X*Y);
    
    %% find resp. indeces
    spmd(threads)
        T = disp_progress('init','building binned means');
        for kk = lims(labindex,1):lims(labindex,2)
            T = disp_progress('show',T,diff(lims(labindex,:)),1000);
            flag = (idx == kk);
            mapCount(kk) = mapCount(kk) + sum(flag);
            mapBinned(kk) = mapBinned(kk) + sum(mapIn(flag));
        end
        mapBinned = gop(@horzcat,mapBinned,1); % cat columns of threads next to each other to later nanmean over dim 2
        mapCount  = gop(@horzcat,mapCount,1);
    end
    
    %% back to master
    mapBinned = gopHorzcat2origShape(mapBinned,Y);
    mapCount  = gopHorzcat2origShape(mapCount ,Y);
    
    %% build means
    mapCount(mapCount==0) = nan;
    mapBinned = mapBinned ./ mapCount;
    
end
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function out = gopHorzcat2origShape(in,Y)
    out = in{1};
    out = nansum(out,2);
    out = reshape(out,Y,[]);
end
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%