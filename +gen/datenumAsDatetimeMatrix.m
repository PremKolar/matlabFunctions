% NK
function out = datenumAsDatetimeMatrix(dn,y,x)
    narginchk(1,3)
    if nargin<2
        y = 1;
        x = 1;
    end
    out = repmat(gen.datetime(dn),y,x);
end