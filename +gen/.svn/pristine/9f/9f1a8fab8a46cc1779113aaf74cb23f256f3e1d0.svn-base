% Current date   = May 15, 2020
% Matlab version = 9.6.0.1072779 (R2019a)
% User name      = U805233
function [x,f,a,b] = findXatWhichAreaUnderLinInterpOf2CoordsHasReachedA(x1,y1,x2,y2,A,xref)
  
    % set x to start the integral from
    if nargin>5
        xr = xref;
    else
        xr = x1;
    end
    
    [f,a,b] = gen.buildLinFunOfTwoCoordinates(x1,y1,x2,y2);
    % constant case (also "step" case)
    if a==0
        x = A/y1 + xr;
        return
    end
    
    % intgrating f from x1 to x yields:
    %     1/2 a (x^2 - xr^2) + b (x - xr)
    % ...solving for x yields
    %     x = (sqrt(a^2 xr^2 + 2 a A + 2 a b xr + b^2) - b)/a % interested only in the solution right of xr!
    % with
    % D = sqrt(a^2 xr^2 + 2 a A + 2 a b xr + b^2)
    % we get
    % x = (D - b)/a
        
    D = sqrt(a^2*xr^2 + 2*a*A + 2*a*b*xr + b^2);
    
    if imag(D)~=0
        x = nan;
        return
    end
    
    % solve
    x = (D - b)/a;
    
end
