% NK
function out = emptyRowVectorOfClass(var,length) %#ok<*STOUT>
    narginchk(1,2)
    if nargin==1
        length=1;
    end
    cl = class(var);    
    eval(sprintf('out = %s.empty(0,%d);',cl,length));
end