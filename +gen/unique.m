% Current date   = February 13, 2020
% Matlab version = 9.6.0.1072779 (R2019a)
% User name      = U805233
% QUICK UNIQUE smae order out as in
function out = unique(varargin)
    try
        in = [varargin{:}];
    catch
        error('all inpuots must be row vectors!')
    end
    out = in;
    if isnumeric(in)
        out(sum(tril(in == in',-1),2)==1) = [];
    else
        out(sum(tril(repmat(in,numel(in),1) == repmat(in',1,numel(in)),-1),2)==1) = []; % for nonnumericls
    end
end