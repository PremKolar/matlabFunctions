% Current date   = April 30, 2020
% Matlab version = 9.6.0.1072779 (R2019a)
% User name      = U805233
function addlistnerSemicolonMissingFinder(basedir)
    if nargin<1
        basedir = pwd;
    end
    d = dir(basedir);
    %     fprintf('scanning %s\n',basedir);
    for k=1:numel(d)
        [~,f,e] = fileparts(d(k).name);
        if d(k).isdir
            if ismember(e,["." ".."])
                continue
            end
            gen.addlistnerSemicolonMissingFinder(fullfile(basedir,d(k).name));
        else
            if ~strcmp(e,'.m')
                continue
            end
            fn = fullfile(basedir,[f,e]);
            fid = fopen(fn);
            if fid == -1
                continue
            end
            line = fgetl(fid);
            ll = 1;
            while ~isnumeric(line)
                if ~isempty(regexp(line,'.*addlistener\(.*\)[^;](\s*\%.*)?$', 'once'))
                    fprintf('\n%s line %d\n%s\n',fn,ll,strip(line));
                end
                line = fgetl(fid);
                ll = ll + 1;
            end
            fclose(fid);
        end
    end
end

