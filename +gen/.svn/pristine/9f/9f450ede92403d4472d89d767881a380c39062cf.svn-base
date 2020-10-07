% eg: matFileLockFile('bla/blubb.mat','block')
% to block 'bla/blubb.mat'
% and
% matFileLockFile('bla/blubb.mat','free')
% to free 'bla/blubb.mat'

function matFileLockFile(matFile,blockOrFree)
    lockFile = fullfile(fileparts(matFile),'lock.mat');
    switch blockOrFree
        case 'block' 
            while true
                if ~exist(lockFile,'file')
                    break
                end
                fprintf('%s is locked. waiting...\n',matFile);
                pause(1);
            end
            fclose(fopen(lockFile,'w'));
        case 'free'
            delete(lockFile);
    end
end
