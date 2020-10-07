% NK
function addFilesToDynamicJavaPath(folder)
    files = dir(folder);
    for j = 3:numel(files)
        try
            gen.javaaddpath(fullfile(folder,files(j).name),1);
        catch me
            disp(me.message)
            fprintf('problems adding %s to dyn. java path.\n',files(j).name);
        end
    end
end
