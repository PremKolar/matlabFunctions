function addpathRecursive(p)
    addpath(p)
    d = dir(p);
    for j=3:numel(d)
       if d(j).isdir && ~strcmp(d(j).name,'private')
          gen.addpathRecursive(fullfile(p,d(j).name)) 
       end
    end
end