% Current date   = January 28, 2020
% Matlab version = 9.6.0.1072779 (R2019a)
% User name      = U805233
function  meta = getMethodMetaForClassOfObj(obj,method)   
        eval(sprintf('Class = ?%s;',class(obj)));    
    meta = Class.MethodList(strcmp({Class.MethodList.Name}, method));
end