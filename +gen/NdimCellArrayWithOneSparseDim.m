% NK
classdef NdimCellArrayWithOneSparseDim < handle
    
    properties (SetAccess = protected)
        M cell % dimensions set by first call to obj.add(frame1)
        rootsizes
    end
    
    properties (Dependent)
        numOfDims
        sizeOfFrame
        numOfFrames
        frameOne
        lastValues
    end
    
    properties (Access = protected)
        lastElementIndeces_ cell
    end
    
    methods
        function addFrame(obj,frame)
            validateattributes(frame,{'cell'},{})
            if isempty(obj.M) % init
                obj.M = shiftdim(frame,-1);
                obj.rootsizes = [1 size(frame)];
            else % append
                assert(all(size(frame) == obj.sizeOfFrame))
                obj.M = cat(1,obj.M,shiftdim(frame,-1));
                obj.lastElementIndeces_(end+1) = cell(1);
            end%
            % no need to clear memory here. still valid for old frames.
        end
        
        function removeFrame(obj,n)
            obj.setNthFrame(n,[]);
            try %#ok
                obj.lastElementIndeces_(n) = [];
            end
        end
        
        function addEmptyFrame(obj)
            assert(obj.numOfFrames>0)
            obj.addFrame(cell(obj.rootsizes{2:end}));
        end
        
        function set.rootsizes(obj,value)
            if ~isempty(obj.numOfFrames) %#ok
                obj.clearMemory(1:obj.numOfFrames); %#ok
            end
            obj.rootsizes = value;
            
        end
        
        function clearMemory(obj,frameIndcs)
            for f=frameIndcs(:)'
                obj.lastElementIndeces_(f) = cell(1);
            end
        end
        
        function out = get.frameOne(obj)
            sizec = num2cell(obj.sizeOfFrame);
            out = reshape(obj.M(1,:),sizec{:});
        end
        
        function out = get.sizeOfFrame(obj)
            out = obj.rootsizes(2:end);
        end
        function out = get.numOfFrames(obj)
            out = size(obj.M,1);
        end
        function out = get.numOfDims(obj)
            out = numel(obj.rootsizes);
        end
        
        % get last nonempty for nth frame
        function out = getNthValues(obj,n)
            gen.validateScalarInteger(n);
            assert(n>0 && n<=obj.numOfFrames)
            % drop to 2-D
            M2d = obj.getM2d(n);
            lastElementIndeces = obj.getLastElementIndeces(n);
            %             out = cell(obj.sizeOfFrame);
            lindx = sub2ind(size(M2d),1:numel(obj.frameOne),lastElementIndeces);
            tmp = num2cell(obj.rootsizes(2:end));
            out = reshape(M2d(lindx),tmp{:});
            %             out(1:numel(obj.frameOne)) =  M2d(lindx);
            assert(~any(cellfun('isempty',out(lastElementIndeces>1))))
            assert(all(size(out)==obj.sizeOfFrame))
        end
        
        % get last nonempty for nth frame
        function [out,n_use] = getNthValue(obj,n,indices,silent)
            if nargin<4 || ~silent
                gen.validateScalarInteger(n);
                validateattributes(indices,{'cell'},{'row'})
                assert(n>0 && n<=obj.numOfFrames);
                assert(numel(indices) == numel(obj.rootsizes)-1);
            end
            tmp = obj.M(1:n,indices{:});
             n_use = find(~gen.isempty(tmp(:,1)),1,'last');
            if isempty(n_use)
                n_use = 1;
            end
%             out = tmp(n_use,:);
            out = squeeze(obj.M(n_use,indices{:})); 
            if numel([indices{:}])==numel(obj.rootsizes)-1
               out = out{1}; 
            end
        end
        
        
        
        % get last nonempty for last frame
        function out = get.lastValues(obj)
            out = obj.getNthValues(obj.numOfFrames);
        end
        
        % set last nonempty for nth frame
        function setNthValues(obj,frame,n)
            gen.validateScalarInteger(n)
            assert(n<=obj.numOfFrames)
            assert(n>0 && n<=obj.numOfFrames)
            assert(all(size(frame) == obj.sizeOfFrame))
            lastElementIndeces = obj.getLastElementIndeces(n);
            
            lindx = sub2ind([prod(obj.rootsizes) obj.numOfFrames],1:numel(obj.frameOne),lastElementIndeces);
            obj.M(lindx) = frame(:);
            % no need to erase memory here
        end
        
        
        function out = getNthFrame(obj,n)
            S.type = '()';
            S.subs = repmat({':'},1,obj.numOfDims);
            S.subs{1} = n;
            out = squeeze(subsref(obj.M,S));
        end
        
        function setNthFrame(obj,n,frame)
            assert(n<=obj.numOfFrames)
            S.type = '()';
            S.subs = repmat({':'},1,obj.numOfDims);
            S.subs{1} = n;
            obj.M = subsasgn(obj.M,S,frame);
            % erase memory
            obj.clearMemory(n:obj.numOfFrames);
        end
        
        % set last nonempty for last frame
        function set.lastValues(obj,frame)
            obj.setNthValues(frame,obj.numOfFrames)
        end
        
        function eraseAllExceptFrameOne(obj)
            obj.clearMemory(2:obj.numOfFrames);
            obj.M = shiftdim(obj.frameOne,-1);
        end
    end
    
    methods (Access = protected)
        function out = getLastElementIndeces(obj,n)
            if nargin<2
                n = obj.numOfFrames;
            end
            if isempty(obj.lastElementIndeces_{n})
                filledCells = ~gen.isempty(obj.getM2d(n));
                filledCells(:,1) = true; % important, if cells were empty on frame 1
                obj.lastElementIndeces_{n} = arrayfun(@(x)find(filledCells(x,:),1,'last'),1:size(filledCells,1));
            end
            out = obj.lastElementIndeces_{n};
        end
        
        function out = getM2d(obj,n)
            if nargin<2
                n = obj.numOfFrames;
            end
            out = reshape(obj.M(1:n,:),n,[])';
        end
    end
    
    methods (Static)
        function [obj, L] = test()
            obj = gen.NdimCellArrayWithOneSparseDim;
            frame = num2cell(rand(4,4,4,4));
            obj.addFrame(frame);
            tmp = rand(4,4,4,4);
            % make sparse
            tmp(tmp<.8) = nan;
            frame2 = num2cell(tmp);
            frame2(cellfun(@isnan,frame2)) = cell(1);
            %
            obj.addFrame(frame2);
            obj.addFrame(frame2);
            L = obj.lastValues;
        end
    end
end