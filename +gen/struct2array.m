% NK
function A = struct2array(S)
   validateattributes(S,{'struct'},{'scalar'}) 
    tmp = struct2cell(S);
    A = vertcat(tmp{:});
end