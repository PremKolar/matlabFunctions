function out = hasDuplicates(in)
    out = numel(unique(in)) < numel(in); 
end