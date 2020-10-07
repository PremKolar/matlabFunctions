% NK
% tested!
classdef FileFinder < handle
    
    
    properties
        showProgress = true
    end
    
    
    properties (SetAccess = protected)
        path char
        keyword char
    end
    
    
    methods
        function obj = FileFinder()            
        end
        
        function setPath(obj,path)
            validateattributes(path,{'char'},{'row'})
            obj.path = path;
        end
        function setKeyword(obj,keyword)
            validateattributes(keyword,{'char'},{'row'})
            obj.keyword = keyword;
        end
        
        function fileLocations = findKeywordInDirNames(obj,path,keyword)
            narginchk(1,3)
            obj.preCheck(path,keyword);
            fileLocations = obj.collectFilesRecursivelyWithKeyword(obj.path,~obj.showProgress,obj.keyword);
        end
        
        function fileLocations = findKeywordInFilenames(obj,path,keyword)
            narginchk(1,3)
            obj.preCheck(path,keyword);
            allfiles = obj.collectFilesRecursivelyWithKeyword(obj.path,~obj.showProgress);
            fprintf('filtering on %s\n',obj.keyword);
            fileLocations = obj.findKeyWordInListOfFilenames(obj.keyword,allfiles);
            if isempty(fileLocations)
                fprintf('nothing found!\n');
            end
        end
    end
    
    
    
    methods (Access = protected)
        
        function preCheck(obj,path,keyword)
            if nargin>1
                obj.setPath(path);
            end
            if nargin>2
                obj.setKeyword(keyword);
            end
            if isempty(obj.path)
                error('set path first!')
            end
            if isempty(obj.keyword)
                error('set search term first!')
            end
        end
        
    end
    
    
    methods (Static,Access = protected)
        
        
        function matches = findKeyWordInListOfFilenames(keyword,allfiles)
            fullnames = cellfun(@(d,f)fullfile(d,f),{allfiles.folder}, {allfiles.name},'UniformOutput',false);
            matchIdcs = ~cellfun('isempty',strfind(fullnames,keyword));
            matches = allfiles(matchIdcs);
        end
        
        % sloow!
        function filesOut = collectFilesRecursivelyWithKeyword(path,silent,keyword)
            if nargin<2
                silent=false;
            end
            if nargin>=3
                filterDirs = true;
            else
                filterDirs = false;
            end
            
            tmp = dir(path);
            tmp(~gen.isempty(regexp({tmp.name},'^\..*'))) = []; % no . and .. and no hiddens
            isdir = [tmp.isdir];
            if ~filterDirs
                files = tmp(~isdir);
            else
                files = [];
            end
            if ~filterDirs
                if ~any(isdir)
                    filesOut = files;
                    if numel(filesOut)>0 && ~silent
                        fprintf('%3d files in %s\n',numel(filesOut),path);
                    end
                    return
                end
            end
            
            fullf = @(t)fullfile(t.folder,t.name);
            if filterDirs
                keywordFound = ~cellfun('isempty',strfind({tmp(:).name}',keyword));
                fisdir.getfiles = find(isdir & keywordFound');
                fisdir.scandirs = find(isdir & ~keywordFound');
                
                for j=fisdir.scandirs(:)'
                    fprintf('scanning %s to look for folders with "%s" in it\n',fullf(tmp(j)),keyword)
                    morefiles = gen.FileFinder.collectFilesRecursivelyWithKeyword(fullf(tmp(j)),silent,keyword);
                    files = [files(:); morefiles(:)];
                end
                for j=fisdir.getfiles(:)'
                    fprintf('collecting all files under %s\n',fullf(tmp(j)))
                    morefiles = gen.FileFinder.collectFilesRecursivelyWithKeyword(fullf(tmp(j)),silent); % scan these witout keyword ie get all files
                    files = [files(:); morefiles(:)];
                end
                filesOut = files;
            else
                fisdir = find(isdir);
                for j=fisdir(:)'
                    morefiles = gen.FileFinder.collectFilesRecursivelyWithKeyword(fullf(tmp(j)),silent);% recurse
                    filesOut = [files(:); morefiles(:)];
                end
            end
            if numel(filesOut)>0 && ~silent
                fprintf('%3d files under %s\n',numel(filesOut),path);
            end
        end
    end
end