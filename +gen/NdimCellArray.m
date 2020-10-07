% Current date   = January 27, 2020
% Matlab version = 9.6.0.1072779 (R2019a)
% User name      = U805233
%
% based on gen.NdimCellArrayWithOneSparseDim. (simplification by making it non sparse..)
classdef NdimCellArray < handle
    
    properties (SetAccess = protected)
        M cell % dimensions set by first call to obj.add(frame1)
        rootsizes
    end
    
    properties (Dependent)
        numOfDims
        sizeOfFrame
        sizeOfFrameAsCell
        numOfFrames
        frameOne
        frameLast
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
            end%
        end
        
        function removeFrame(obj,n)
            obj.setNthFrame(n,[]);
        end
        
        function addCopyOfNthFrame(obj,n)
            assert(obj.numOfFrames>0)
            assert(n<=obj.numOfFrames)
            obj.addFrame(obj.getNthFrame(n));
            obj.resortFrames([1:n obj.numOfFrames n+1:obj.numOfFrames-1]);
        end
        
        function resortFrames(obj,ordr)
            validateattributes(ordr,{'double'},{'vector','numel',obj.numOfFrames,'>',0,'<=',obj.numOfFrames});
            S = obj.buildIndexStructForFullFrame(ordr);          
            obj.M = subsref(obj.M,S);
        end
        
        function addCopyOfLastFrame(obj)
            assert(obj.numOfFrames>0)
            obj.addFrame(obj.getNthFrame(obj.numOfFrames));
        end
        
        
        function out = get.frameOne(obj)
            out = obj.getNthFrame(1);
        end
        function out = get.frameLast(obj)
            out = obj.getNthFrame(obj.numOfFrames);
        end
        
        
        function out = get.sizeOfFrame(obj)
            out = obj.rootsizes(2:end);
        end
        function out = get.sizeOfFrameAsCell(obj)
            out = num2cell(obj.sizeOfFrame);
        end
        
        function out = get.numOfFrames(obj)
            out = size(obj.M,1);
        end
        function out = get.numOfDims(obj)
            out = numel(obj.rootsizes);
        end
        
        
        function out = getNthFrame(obj,n)
          S = obj.buildIndexStructForFullFrame(n);
            out = squeeze(subsref(obj.M,S));
        end
        
        function setNthFrame(obj,n,frame)
            assert(n<=obj.numOfFrames)
          S = obj.buildIndexStructForFullFrame(n);
            obj.M = subsasgn(obj.M,S,frame);
        end
        
        
        function eraseAllExceptFrameOne(obj)
            obj.M = shiftdim(obj.frameOne,-1);
        end
    end
    
    methods (Access = protected)
        % independent of num of dims and safer than shiftdim
        function S = buildIndexStructForFullFrame(obj,n)
             S.type = '()';
            S.subs = repmat({':'},1,obj.numOfDims);
            S.subs{1} = n;
        end
    end
    
    methods (Static)
        function [obj, L] = test()
            obj = gen.NdimCellArray;
            frame = num2cell(rand(4,4,4,4));
            obj.addFrame(frame);
            frame1 = num2cell(rand(4,4,4,4)*10);
            frame2 = num2cell(rand(4,4,4,4)*100);
            
            
            %
            obj.addFrame(frame1);
            obj.addFrame(frame2);
            obj.addCopyOfLastFrame()
            obj.addCopyOfNthFrame(2)
            L = obj.lastValues;
        end
    end
end