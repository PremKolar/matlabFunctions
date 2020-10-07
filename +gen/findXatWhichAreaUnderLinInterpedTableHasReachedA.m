% Current date   = May 15, 2020
% Matlab version = 9.6.0.1072779 (R2019a)
% User name      = U805233
%
% x: x-indices
% y: y-indices
% x_ref: x-start-value for integral
% A: Area under graph from x_ref till x_out
% show: set to true to visualize alogrithm
% x_show: found x-value up to which the function needs to be integrated to reach area A
% step: set to true to not interpolate, but instead integrate the step function
function [x_out,xdif] = findXatWhichAreaUnderLinInterpedTableHasReachedA(x,y,x_ref,A,show,step)
    narginchk(4,6)
    
    assert(all(diff(x)>=0))
    assert(numel(x) == numel(y))
    
    if nargin<6 || ~step
        xFindFun = @(x1,y1,x2,y2,A,x_ref)gen.findXatWhichAreaUnderLinInterpOf2CoordsHasReachedA(x1,y1,x2,y2,A,x_ref);
    else
        xFindFun = @(x1,y1,x2,y2,A,x_ref)findXatWhichAreaUnderStepHasReachedA(x1,y1,x2,y2,A,x_ref);
    end
    
    % find 2 neighbours to x_ref
    ii_start = find(x<=x_ref,1,'last');
    
    [x_t,f] = xFindFun(x(ii_start),y(ii_start),x(ii_start+1),y(ii_start+1),A,x_ref);
    if ~isnan(x_t) && x_t<=x(ii_start+1) % case that x_out was found within first segment of graph
        x_out = x_t;
        xdif = x_out - x_ref;
        if nargin>4 && show
            visualize(x,y,x_out,x_ref);
        end
        return
    else % otherwise continue to next segment recursively until A has reached 0
        A = A - integral(f,x_ref,x(ii_start+1)); % substract area resulting from prior segment
        x_out = gen.findXatWhichAreaUnderLinInterpedTableHasReachedA(x,y,x(ii_start+1),A); % recurse, now starting at next segment
        xdif = x_out - x_ref; % total xdif
        if nargin>4 && show
            visualize(x,y,x_out,x_ref);
        end
        
    end
end

function [x_t,f] = findXatWhichAreaUnderStepHasReachedA(x1,y1,x2,~,A,x_ref)
    % simple hack..
    [x_t,f] = gen.findXatWhichAreaUnderLinInterpOf2CoordsHasReachedA(x1,y1,x2,y1,A,x_ref); % NOTE: using y1 at x2!
end

% for debugging
function visualize(x,y,x_out,x_ref)
    persistent fig
    if isempty(fig) || ~isvalid(fig)
        fig = figure;
    else
        figure(fig);
    end
    clf
    x = x(:)';
    y = y(:)';
    x(x<-1e6) = -1e12;
    x(x> 1e6) = 1e12;
    
    xa = [x_ref x(x>x_ref & x<x_out) x_out];
    area(xa,interp1(x,y,xa))
    hold on
    plot(x,y,'LineWidth',2,'Color','red')
    offset = (x_out - x_ref)/4;
    set(gca,'XLim',[x_ref - offset,x_out + offset]);
    grid minor
end