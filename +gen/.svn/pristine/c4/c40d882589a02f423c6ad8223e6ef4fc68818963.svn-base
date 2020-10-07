% eg:
% block =
% engine: V2500
% rating: 27k
% key out   <------------------
% environment: Moderate
% hardware: Classic
% run: Nrun
function out = findValueToKeyInCharBlock(block,key)
    [a,b] = regexp(block,[key ' [^\n]*']);
    out = block(a+numel(key):b);
end