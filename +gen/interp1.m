% Current date   = June 03, 2020
% Matlab version = 9.1.0.441655 (R2016b)
% User name      = U805233
%
% faster linear regression
function [yq,p] = interp1(x,y,xq,varargin)
    
    %     assert(all(diff(x)>=0)) % slow
    
    if numel(varargin)>0
        if ~strcmp(varargin{1},'linear')
            error('can only do linear for now')
        end
    end
    
    %% lin. regr.
    X = [ones(length(x),1) x(:)];
    p = flipud(X\y(:));                         % see https://www.mathworks.com/help/matlab/data_analysis/linear-regression.html
    %     flin = @(x_)p(1)*x_ + p(2); % slow
    yq = p(1)*xq + p(2);    
 
end

















function test()
    x = sort(rand(1,1000)*1000);
    y = 3*x + rand(1,1000)*1000;
    xq = rand(1,1000)*1000;
    for ii=1:1000
        yqml(ii) = interp1(x,y,xq(ii),'linear','extrap') ;
    end
    for ii=1:1000
        yqthis(ii) = gen.interp1(x,y,xq(ii),'linear','extrap') ;
    end
    plot(xq,yqml,'r*',xq,yqthis,'b*');
end