% avoid problems with size=[1,x] data
function t=table(varargin)
    t=table;
    for j=1:numel(varargin)
        t.(inputname(j)) = reshape(varargin{j},[],1);
    end
end