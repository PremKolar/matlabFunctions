% Current date   = 2019
% Matlab version = 9.6.0.1072779 (R2019a)
% User name      = U805233
function out = isDistinct(in,skipEmpties)
    if nargin<2
        skipEmpties = false;
    end
    if iscell(in) && isnumeric(in{1})
        in = cell2mat(in);
    end
    if skipEmpties
       in(gen.isempty(in)) = []; 
    end
    out = numel(unique(in)) == numel(in);
end