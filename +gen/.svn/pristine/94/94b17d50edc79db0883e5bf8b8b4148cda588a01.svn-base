function out = deleteEmptyCells(in)
    validateattributes(in,{'cell'},{'vector'})
    e = gen.isempty(in);
    out = in(~e);
    validateattributes(out,{'cell'},{'vector'})
    assert(numel(out)<=numel(in));
end