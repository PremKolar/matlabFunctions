% Current date   = March 20, 2020
% Matlab version = 9.6.0.1072779 (R2019a)
% User name      = U805233
function obj = setDeepField(obj,field,value)
    validateattributes(field,{'char'},{'row'})
    fields = strsplit(field,'.');

    S = struct;
    for f=1:numel(fields)
        S(f).type = '.';
        S(f).subs = fields{f};
    end
    
    obj = subsasgn(obj,S,value);
end