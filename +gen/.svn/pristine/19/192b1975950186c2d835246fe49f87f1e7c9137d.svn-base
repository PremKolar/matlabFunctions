% NK
% delete all objects and set the array to length 0 but keep the class
function A = clearObjArray(A)
    validateattributes(A,{'handle'},{})
    arrayfun(@delete,A);
    eval(sprintf('A = %s.empty;',class(A)));
end