% Current date   = May 20, 2020
% Matlab version = 9.6.0.1072779 (R2019a)
% User name      = U805233
function [f,a,b] = buildLinFunOfTwoCoordinates(x1,y1,x2,y2)
    narginchk(4,4)
    % build lin. f
    a = (y2-y1)/(x2-x1);
    b = y2 - a*x2;
    if isnan(b)
        b =  y1 - a*x1;
    end
    
    % constant case
    if a==0
        f = @(x)b*ones(size(x));
    else
        f = @(x)a*x + b;
    end
    
end