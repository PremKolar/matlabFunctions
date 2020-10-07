function createNecessaryFolderStructure(file)
    validateattributes(char(file),{'char'},{'row'})
    D = fileparts(file);    
    ds = strsplit(D,filesep);
    
    for j=2:numel(ds)
        subdir = fullfile(ds{1:j});
        if ~exist(subdir,'dir')
            mkdir(subdir);
        end
    end
    
end