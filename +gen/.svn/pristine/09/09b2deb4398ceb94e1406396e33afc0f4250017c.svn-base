% NK
function [xout,yout] = declutter2Dcoordinates(xin,yin)
    xout = xin;
    yout = yin;
    
    ydif = (yin-yin').*(triu(nan(length(xin)))+1);
    xdif = (xin-xin').*(triu(nan(length(xin)))+1);
    
    [jj,ii] = find(~isnan(ydif));
    
    for k =1:numel(jj)
       
        if abs(ydif(jj(k),ii(k))) <0.2 && abs(xdif(jj(k),ii(k))) <1
            yout(jj(k)) = yout(jj(k)) + sign(ydif(jj(k))) * .1;
        end        
    end   
end