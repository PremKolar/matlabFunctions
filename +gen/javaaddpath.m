function javaaddpath(jar,force)
if nargin <2
    force=false;
end
javaStatic  = javaclasspath('-static');
javaDynamic = javaclasspath('-dynamic');
[~,jarf,ext] = fileparts(jar);
isOnPath=@(p)any(~cellfun('isempty',cellfun(@(x)strfind(x,[jarf ext]),p,'UniformOutput',0)));
if (~isOnPath(javaStatic) && ~isOnPath(javaDynamic)) || force
    if force
        warning('off')
        javaaddpath(jar);
        warning('on')
    else
        javaaddpath(jar);
    end
end
end