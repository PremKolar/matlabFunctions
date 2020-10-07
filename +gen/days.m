% NK
function out = days(d,y,x)
    narginchk(1,3)
    if nargin<2
        y = 1;
        x = 1;
    end
    out = repmat(duration(d*24,0,0),y,x);
end