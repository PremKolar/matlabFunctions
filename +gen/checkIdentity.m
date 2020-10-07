% NK
function out = checkIdentity(A,B,numPrecision)
    narginchk(2,3)
    if nargin<3
        numPrecision = 0;
    end
    
    if ~isa(A,class(B))
        out = false;
        return
    end
    
    if isnumeric(A)
        if isnan(A)
            out = isnan(B);
        elseif isinf(A)
            out = isinf(B);
        else
            out = all(abs(A(:) - B(:)) <= numPrecision);
        end
    elseif ischar(A)
        out = all(strcmp(A(:),B(:)));
    elseif isobject(A) || islogical(A)
        out = all(A(:) == B(:));
    elseif iscell(A)
        if ~all(size(A)==size(B))
            out = false;
            return
        end
        for c=1:numel(A)
           out = gen.checkIdentity(A{c},B{c});
           if ~out
               return
           end
        end   
    elseif isstruct(A)
        FNa = fieldnames(A);
        FNb = fieldnames(B);
       if ~(all(ismember(FNa,FNb)) && all(ismember(FNa,FNb)))
           out = false;
           return
       end
       for f=1:numel(FNa)
           fn = FNa{f};
           out = gen.checkIdentity(A.(fn),B.(fn));
           if ~out
               return
           end
       end
    else
        error('not yet impled')
    end
    
end